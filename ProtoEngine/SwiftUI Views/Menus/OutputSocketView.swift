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

    var body: some View {
        Circle()
            .fill(Color.red)
            .frame(width: 20)
            .draggable(
                DraggableData(
                    socketID: self.outputSocket.id!,
                    sourceNodeID: ofNode
                )
            )
        //            .draggable(
        //                DraggableData(socketID: self.outputSocket.id!)
        //            )
    }
}
