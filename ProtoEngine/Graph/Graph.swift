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

    func evaluate() {

    }

    func addNode(_ node: Node) {
        node.id = NodeID(nodes.count)
        
        for output in node.outputs {
            uidsMap[PartialLink(node: node.id!, socket: output.id!,isOutput: true)] = UUID()
        }
        for input in node.inputs {
            uidsMap[PartialLink(node: node.id!, socket: input.id!, isOutput: false)] = UUID()
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
