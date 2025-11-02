//
//  InputSocketView.swift
//  ProtoEngine
//
//  Created by Milton Montiel on 01/11/25.
//

import SwiftUI

struct InputSocketView: View {
    let inputSocket: any Socket
    let ofNode: NodeID

    @State private var isDragTargeted = false
    @Environment(Graph.self) var graph: Graph

    var body: some View {
        Circle()
            .fill(Color.blue)
            .frame(width: 20)
            .dropDestination(for: DraggableData.self) {
                draggableData,
                location in
                if let first = draggableData.first {
                    self.graph.connect(
                        from: first.sourceNodeID,
                        atOutput: first.socketID,
                        to: ofNode,
                        atInput: inputSocket.id!
                    )
                    Graph.Evaluator(graph: self.graph).evaluate()
                    return true
                }
                return true
            } isTargeted: {
                isDragTargeted = $0
            }
            .anchorPreference(
                key: SocketAnchorKey.self,
                value: .center,
                transform: {
                    anchor in
                    [
                        graph.uidsMap[
                            PartialLink(
                                node: ofNode,
                                socket: inputSocket.id!,
                                isOutput: false
                            )
                        ]!: anchor
                    ]
                }
            )
            .help("\(inputSocket.id!)")
    }
}
