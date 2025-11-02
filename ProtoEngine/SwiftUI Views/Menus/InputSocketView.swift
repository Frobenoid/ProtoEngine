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
                print("Dropped at \(self.inputSocket.id!)")
                if let first = draggableData.first {
                    self.graph.connect(
                        from: first.sourceNodeID,
                        atOutput: first.socketID,
                        to: ofNode,
                        atInput: inputSocket.id!
                    )
                    return true
                }
                return true
            } isTargeted: {
                isDragTargeted = $0
            }.help("\(inputSocket.id!)")
    }
}
