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
            .connect(to: to, atInput: atInput)
    }

    func getLinks() -> [Link] {
        var t: [Link] = []
        for node in nodes {
            for x in node.getNeighbors() {
                var y = x
                y.sourceNode = node.id!
                t.append(y)
            }
        }

        return t
    }
}

extension Graph {
    private func execute(node: NodeID) {
        nodes[node].execute()
    }

    private func propagateValue(for node: NodeID) {
        for link in nodes[node].getNeighbors() {
            let output = nodes[link.sourceNode].getUntypedOutput(
                at: link.sourceSocket
            )
            nodes[link.destinationNode].inputs[link.destinationSocket]
                .setUntypedCurrentValue(to: output)
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
        private var visited: Set<NodeID> = []
        private var executionOrder: [NodeID] = []

        init(graph: inout Graph) {
            self.graph = graph
        }

        private func verifyIntegrity() {
        }

        private func dfs() {
            // Setting all nodes to white.
            let colors: [NodeID: Color] = Dictionary(
                uniqueKeysWithValues: graph.nodes.map { node in
                    return (node.id!, .WHITE)
                }
            )

            graph.nodes.indices.filter { colors[$0] == .WHITE }.forEach {
                node in
                visit(node: node)
            }

        }

        func visit(node: NodeID) {
            colors[node] = .GRAY
            visited.insert(node)

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

            // Finish exploring the current node.
            executionOrder.append(node)
            colors[node] = .BLACK
        }

        func evaluate() {
            verifyIntegrity()

            executionOrder.reversed().forEach { node in
                graph.execute(node: node)
                graph.propagateValue(for: node)
            }
        }
    }
}
