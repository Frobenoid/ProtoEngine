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
    @State private var needsRedraw: Bool = false
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                ForEach(graph.nodes, id: \.id!) { node in
                    NodeView(node: node).environment(graph)
                }
            }
            .offset(geo.size / 2)
            .coordinateSpace(name: "graph")
            .overlayPreferenceValue(SocketAnchorKey.self) { socketAnchors in
                let links = graph.getLinks()
                
                ForEach(links, id: \.hashValue){ link in
                    if let sourceAnchor = socketAnchors[graph.uidsMap[PartialLink(node: link.sourceNode, socket: link.sourceSocket, isOutput: true)]!],
                       let destAnchor = socketAnchors[graph.uidsMap[PartialLink(node: link.destinationNode, socket: link.destinationSocket, isOutput: false)]!] {
                        
                        let start = geo[sourceAnchor]
                        let end = geo[destAnchor]
                        
                        Path { path in
                            path.move(to: start)
                            path.addLine(to: start)
                            path.addCurve(to: end, control1: start, control2: end)
                            path.addLine(to: end)
                        }
                        .stroke(Color.black, lineWidth: 9)
                        .onTapGesture(count: 2) {
                            self.needsRedraw.toggle()
                        }
                    }
                       
                }
            }
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
