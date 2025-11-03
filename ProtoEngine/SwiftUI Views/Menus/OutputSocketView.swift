//
//  OutputSocket.swift
//  ProtoEngine
//
//  Created by Milton Montiel on 01/11/25.
//

import SwiftUI

struct OutputSocketView: View {
    let outputSocket: any Socket
    let ofNode: NodeID
    @Environment(Graph.self) var graph: Graph

    var body: some View {
        HStack {
            Text(
                "\(graph.shouldUpdate ? "" : "")\(outputSocket.untypedCurrentValue())"
            )
            Circle()
                .fill(Color.red)
                .frame(width: 20)
                .anchorPreference(
                    key: SocketAnchorKey.self,
                    value: .center,
                    transform: { anchor in
                        [
                            graph.uidsMap[
                                PartialLink(
                                    node: ofNode,
                                    socket: outputSocket.id!,
                                    isOutput: true
                                )
                            ]!: anchor
                        ]
                    }
                )
                .draggable(
                    DraggableData(
                        socketID: self.outputSocket.id!,
                        sourceNodeID: ofNode
                    )
                )
        }
    }
}
