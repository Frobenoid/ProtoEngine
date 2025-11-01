//
//  NodeMenu.swift
//  ProtoEngine
//
//  Created by Milton Montiel on 01/11/25.
//

import SwiftUI
import QGraph

//Text("Graph with \(graph.num_of_nodes()) nodes")
//Button("Add node") {
//    graph.add_node(T: qgraph.ConstantNode.self)
//}
struct NodeMenu: View {
    @Binding var graph: qgraph.Graph
    var body: some View {
        VStack {
            Text("Nodes").font(.title)
            Text("Graph with \(graph.num_of_nodes()) nodes").font(.subheadline)
            Divider()
            Text("").font(.title2)
            Button("Add constant node") {
                graph.add_node(T: qgraph.ConstantNode.self)
            }
        }.padding(10)
            .frame(width: 300)
            .background()
            .cornerRadius(10)
    }
}

#Preview {
    @Previewable @State var graph = qgraph.Graph()
    NodeMenu(graph: $graph)
}
