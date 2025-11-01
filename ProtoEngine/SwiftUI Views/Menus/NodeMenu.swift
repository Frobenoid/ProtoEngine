//
//  NodeMenu.swift
//  ProtoEngine
//
//  Created by Milton Montiel on 01/11/25.
//

import SwiftUI
import QGraph

struct NodeMenu: View {
    @Environment(Graph.self) var graph
    
    var body: some View {
        VStack {
            Text("Nodes").font(.title)
            Text("Graph with \(graph.nodes.count) nodes").font(.subheadline)
            Divider()
            Text("").font(.title2)
            Button("Add constant node") {
                graph.addNode(ConstantNode())
            }
            Button("Add math node") {
                graph.addNode(MathNode())
            }
        }.padding(10)
            .frame(width: 300)
            .background()
            .cornerRadius(10)
    }
}

#Preview {
    @Previewable @State var graph = Graph()
    NodeMenu().environment(graph)
}
