//
//  NodeMenu.swift
//  ProtoEngine
//
//  Created by Milton Montiel on 01/11/25.
//

import QGraph
import SwiftUI

struct NodeMenu: View {
    @Environment(Graph.self) var graph
    @Binding var showNodes: Bool
    
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
            Toggle("Show Nodes", isOn: $showNodes).toggleStyle(.switch)
        }.padding(10)
            .frame(width: 300)
            .background()
            .cornerRadius(10)
    }
}

#Preview {
    @Previewable @State var graph = Graph()
    @Previewable @State var showNodes = true
    NodeMenu(showNodes: $showNodes).environment(graph)
}
