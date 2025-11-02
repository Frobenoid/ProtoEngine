//
//  Graph.swift
//  ProtoEngine
//
//  Created by Milton Montiel on 01/11/25.
//

import Foundation

struct PartialLink: Hashable {
    var node: NodeID
    var socket: SocketID
    var isOutput: Bool
}

@Observable
class Graph {
    var nodes: [Node] = []

    var uidsMap: [PartialLink: UUID] = [:]

    private(set) var links: [Link] = []

    func addNode(_ node: Node) {
        node.id = NodeID(nodes.count)

        for output in node.outputs {
            uidsMap[
                PartialLink(node: node.id!, socket: output.id!, isOutput: true)
            ] = UUID()
        }
        for input in node.inputs {
            uidsMap[
                PartialLink(node: node.id!, socket: input.id!, isOutput: false)
            ] = UUID()
        }
        nodes.append(node)
    }

    func connect(
        from: NodeID,
        atOutput: SocketID,
        to: NodeID,
        atInput: SocketID
    ) {
        nodes[from]
            .outputs[atOutput]
            .connect(parentNode: from, to: to, atInput: atInput)
        updateLinks()
    }

    func disconnect(
        link: Link
    ) {
        nodes[link.sourceNode].outputs[link.sourceSocket].disconnect(link: link)
        updateLinks()
    }

    private func updateLinks() {
        var t: [Link] = []
        nodes.forEach { node in
            node.getNeighbors().forEach {
                var y = $0
                y.sourceNode = node.id!
                t.append(y)
            }
        }
        links = t
        print(links)
    }
}

extension Graph {
    private func execute(node: NodeID) {
        print("Executing node \(node)")
        nodes[node].execute()
    }

    private func propagateValue(for node: NodeID) {
        for link in nodes[node].getNeighbors() {
            var output = nodes[link.sourceNode].getUntypedOutput(
                at: link.sourceSocket
            )
            nodes[link.destinationNode].inputs[link.destinationSocket]
                .setUntypedCurrentValue(to: output.untypedCurrentValue())
        }
    }

    private func computeExecutionOrder() -> [NodeID] {
        return []
    }

    final class Evaluator {
        enum Color {
            case WHITE
            case GRAY
            case BLACK
        }

        private var graph: Graph
        private var colors: [NodeID: Color] = [:]
        private var executionOrder: [NodeID] = []

        init(graph: Graph) {
            self.graph = graph
        }

        private func verifyIntegrity() {
            self.executionOrder = []
            dfs()
        }

        private func dfs() {
            // Setting all nodes to white.
            self.colors = Dictionary(
                uniqueKeysWithValues: graph.nodes.map { node in
                    return (node.id!, .WHITE)
                }
            )

            graph.nodes.indices.forEach { node in
                if self.colors[node] == .WHITE {
                    visit(node: node)
                }
            }

        }

        func visit(node: NodeID) {
            // Mark as discovered
            colors[node] = .GRAY

            let neighbors = graph.nodes[node].getNeighbors()

            // Check if there are directed cycles.
            if (neighbors.contains { colors[$0.destinationNode] == .GRAY }) {
                // We can recover from this, so it musnt be a fatal error.
                fatalError("Graph is invalid")
            }

            // Visit unexplored nodes.
            neighbors.filter { colors[$0.destinationNode] == .WHITE }.forEach {
                visit(node: $0.destinationNode)
            }

            // Mark as explored
            executionOrder.append(node)
            colors[node] = .BLACK
        }

        func evaluate() {
            print("Evaluating!")
            verifyIntegrity()

            print(executionOrder)
            executionOrder.reversed().forEach { node in
                graph.execute(node: node)
                graph.propagateValue(for: node)
            }
        }
    }
}
