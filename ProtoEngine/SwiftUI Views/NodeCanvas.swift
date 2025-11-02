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

                ForEach(links, id: \.hashValue) { link in
                    if let sourceAnchor = socketAnchors[
                        graph.uidsMap[
                            PartialLink(
                                node: link.sourceNode,
                                socket: link.sourceSocket,
                                isOutput: true
                            )
                        ]!
                    ],
                        let destAnchor = socketAnchors[
                            graph.uidsMap[
                                PartialLink(
                                    node: link.destinationNode,
                                    socket: link.destinationSocket,
                                    isOutput: false
                                )
                            ]!
                        ]
                    {

                        let start = geo[sourceAnchor]
                        let end = geo[destAnchor]

                        computePath(start: start, end: end)
                            .strokedPath(
                                StrokeStyle(
                                    lineWidth: 5,
                                    lineCap: .round,
                                    lineJoin: .bevel,
                                    dash: [10, 10],
                                    dashPhase: 5
                                )
                            )
                            .stroke(Color.black.opacity(0.9), lineWidth: 2)
                            .fill(
                                Color.black.opacity(0.2)
                            )
                            //                            .stroke(Color.gray.opacity(0.9), lineWidth: 5)
                            .onTapGesture(count: 2) {
                                self.needsRedraw.toggle()
                            }
                    }

                }
            }
        }
    }

    private func computePath(start: CGPoint, end: CGPoint) -> Path {
        let stemHeight: CGFloat = self.clamp(
            abs(end.y - start.y) / 4.0,
            lowerBound: 5.0,
            upperBound: 35.0
        )
        let stemOffset: CGFloat = self.clamp(
            self.dist(p1: start, p2: end) / 4.0,
            lowerBound: 5.0,
            upperBound: 35.0
        ) /*min( max(5, self.dist(p1: start, p2:end)), 40 )*/

        let start1: CGPoint = CGPoint(
            x: start.x + stemHeight,
            y: start.y
        )

        let end1: CGPoint = CGPoint(
            x: end.x - stemHeight,
            y: end.y
        )

        let controlOffset: CGFloat = max(
            stemHeight + stemOffset,
            abs(end1.y - start1.y) / 2.4
        )
        let control1 = CGPoint(x: start1.x + controlOffset, y: start1.y)
        let control2 = CGPoint(x: end1.x - controlOffset, y: end1.y)

        return
            Path { path in
                path.move(to: start)
                path.addLine(to: start1)
                path.addCurve(to: end1, control1: control1, control2: control2)
                path.addLine(to: end)
            }
    }

    private func clamp(_ x: CGFloat, lowerBound: CGFloat, upperBound: CGFloat)
        -> CGFloat
    {
        return max(min(x, upperBound), lowerBound)
    }

    private func dist(p1: CGPoint, p2: CGPoint) -> CGFloat {
        let distance = hypot(p1.x - p2.x, p1.y - p2.y)
        return distance
    }
}

#Preview {
    @Previewable @State var graph: Graph = {
        var g = Graph()
        g.addNode(ConstantNode())
        g.addNode(MathNode())
        g.connect(from: 0, atOutput: 0, to: 1, atInput: 0)
        return g
    }()

    NodeCanvas().environment(graph)
}
