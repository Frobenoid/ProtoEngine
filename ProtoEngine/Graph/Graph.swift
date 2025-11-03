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
    var shouldUpdate: Bool = false

    func addNode(_ node: Node) {
        node.id = NodeID(nodes.count)

        node.outputs.forEach { output in
            uidsMap[
                PartialLink(node: node.id!, socket: output.id!, isOutput: true)
            ] = UUID()

        }

        node.inputs.forEach { input in
            uidsMap[
                PartialLink(node: node.id!, socket: input.id!, isOutput: false)
            ] = UUID()
        }

        nodes.append(node)
    }

    func connect(link: Link) {
        links.append(link)
    }

    func disconnect(link: Link) {
        // Remove the link
        if let index = links.firstIndex(of: link) {
            links.remove(at: index)
        } else {
            fatalError("Tried to remove a link that wasn't in the list")
        }
        // Restore to default value for output/input sockets
        nodes[link.sourceNode].outputs[link.sourceSocket]
            .restoreToDefaultValue()
        nodes[link.destinationNode].inputs[link.destinationSocket]
            .restoreToDefaultValue()
    }

}

extension Graph {
    private func execute(node: NodeID) {
        print("Executing node \(node)")
        nodes[node].execute()
    }

    private func propagateValue(for node: NodeID) {
        links.forEach { link in
            let output = nodes[link.sourceNode].getUntypedOutput(
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

            let neighbors = graph.links.filter { $0.sourceNode == node }

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
            graph.shouldUpdate.toggle()
        }
    }
}
