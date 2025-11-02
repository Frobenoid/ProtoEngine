//
//  Graph.swift
//  ProtoEngine
//
//  Created by Milton Montiel on 01/11/25.
//

import Foundation

@Observable
class Graph {
    var nodes: [Node] = []

    func evaluate() {

    }

    func addNode(_ node: Node) {
        node.id = NodeID(nodes.count)
        nodes.append(node)
    }

    func connect(
        from: NodeID,
        atOutput: SocketID,
        to: NodeID,
        atInput: SocketID
    ) {
        print(
            "Connecting(\(from),\(atOutput)) to (\(to),\(atInput))"
        )
        nodes[Int(from)]
            .outputs[Int(atOutput)]
            .connect(to: to, atInput: atInput)
    }
}
