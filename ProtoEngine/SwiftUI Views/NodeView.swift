//
//  NodeView.swift
//  ProtoEngine
//
//  Created by Milton Montiel on 01/11/25.
//

import QGraph
import SwiftUI

struct NodeView: View {
    @Binding var graph: qgraph.Graph
    var node: qgraph.NodeId

    var body: some View {
        if graph.num_of_nodes() > 0 {
            var current = graph.node(node)
            ZStack {
                VStack(
                    alignment: .leading,
                    spacing: 20,
                ) {
                    Text("Node \(current.pointee.id())")
                        .font(.title)
                        .frame(maxHeight: 20)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 20)
                }.frame(width: 200, height: 100, alignment: .leading)
                
            }
            .background(Color.black)
            .frame(width: 200, height: 100)
            .cornerRadius(10)
            .gesture(
                TapGesture(count: 1)
                    .onEnded({value in
                        print("Tapped node \(current.pointee.id())")
                    })
            )
        }

    }
}

//#Preview {
//    @Previewable @State var graph: qgraph.Graph = .init()
//    NodeView()
//}
