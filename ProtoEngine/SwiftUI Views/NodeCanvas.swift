//
//  NodeCanvas.swift
//  ProtoEngine
//
//  Created by Milton Montiel on 01/11/25.
//

import QGraph
import SwiftUI

extension CGSize {
    public static func / (lhs: CGSize, rhs: CGFloat) -> CGSize {
        return CGSize(width: lhs.width / rhs, height: lhs.height / rhs)
    }

    public static func + (lhs: CGSize, rhs: CGSize) -> CGSize {
        return CGSize(
            width: lhs.width + rhs.width,
            height: lhs.height + rhs.height
        )

    }
}

struct NodeCanvas: View {

    @Environment(Graph.self) var graph: Graph

    var body: some View {
        GeometryReader { geo in
            ZStack {
                ForEach(graph.nodes, id: \.id!) { node in
                    NodeView(node: node).environment(graph)
                }
            }
            .offset(geo.size / 2)
            .coordinateSpace(name: "graph")
        }
    }
}

#Preview {
    @Previewable @State var graph: Graph = {
        var g = Graph()
        g.addNode(MathNode())
        return g
    }()

    NodeCanvas().environment(graph)
}
