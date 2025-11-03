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
        HStack {

            Circle()
                .fill(Color.blue)
                .frame(width: 20)
                .dropDestination(for: DraggableData.self) {
                    draggableData,
                    location in
                    if let first = draggableData.first {
                        self.graph.connect(
                            link: Link(
                                sourceNode: first.sourceNodeID,
                                sourceSocket: first.socketID,
                                destinationNode: ofNode,
                                destinationSocket: inputSocket.id!
                            )
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
            Text(
                "\(graph.shouldUpdate ? "" : "")\(inputSocket.untypedCurrentValue())"
            )
        }
    }
}
