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
        ZStack {
            ForEach($graph.nodes, id: \.id!) { node in
                NodeView(node: node)
            }
        }
    }
}

#Preview {
    @Previewable @State var graph: Graph = Graph()
    NodeCanvas(graph: $graph)
}
