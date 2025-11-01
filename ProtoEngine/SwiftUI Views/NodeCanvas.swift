//
//  NodeCanvas.swift
//  ProtoEngine
//
//  Created by Milton Montiel on 01/11/25.
//

import QGraph
import SwiftUI

struct NodeCanvas: View {

    @Binding var graph: Graph

    var body: some View {
        Text("Currently \(graph.nodes.count) nodes")

        ForEach(graph.nodes) { node in
            Text("\(node.id)")
        }
    }
}

#Preview {
    @Previewable @State var graph: Graph = Graph()
    NodeCanvas(graph: $graph)
}
