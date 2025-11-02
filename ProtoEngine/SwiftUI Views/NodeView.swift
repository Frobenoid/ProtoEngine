//
//  NodeView.swift
//  ProtoEngine
//
//  Created by Milton Montiel on 01/11/25.
//

import QGraph
import SwiftUI

extension Binding {
    func toAny<Base>() -> Binding<Base> {
        return Binding<Base>(
            get: {
                return self.wrappedValue as! Base
            },
            set: { newValue in
                guard let newSpecific = newValue as? Value else {
                    return
                }
                self.wrappedValue = newSpecific
            }
        )

    }
}

struct NodeView: View {
    let node: Node
    @Environment(Graph.self) var graph: Graph

    @State private var offset = CGSize.zero
    @GestureState private var dragOffset: CGSize = .zero
    @State private var isDragging = false
    @State private var isSelected: Bool = false

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack(alignment: .leading, spacing: 20) {
                    Text("\(node.label), ID(\(node.id!))")
                        .font(.subheadline)
                        .bold()
                        .frame(maxHeight: 20)
                        .padding(.horizontal, 30)

                    Divider()

                    ForEach(node.inputs, id: \.id) { input in
                        InputSocketView(inputSocket: input, ofNode: node.id!)
                            .padding(.horizontal, 10)
                    }
                    Spacer(minLength: 0)
                }
                .frame(width: 200, height: 150, alignment: .leading)

                VStack(alignment: .trailing, spacing: 20) {
                    Spacer()
                    ForEach(node.outputs, id: \.id) { output in
                        OutputSocketView(outputSocket: output, ofNode: node.id!)
                            .padding(.horizontal, 10)
                    }
                    Spacer()
                }
                .frame(width: 200, height: 150, alignment: .trailing)
            }.padding(.vertical, 25)
        }
        .background()
        .frame(width: 200, height: 170)
        .cornerRadius(10)
        .offset(
            self.node.isDragging
                ? CGSize(
                    width: self.offset.width + self.dragOffset.width,
                    height: self.offset.height + self.dragOffset.height
                )
                : self.node.offset
        )
        .gesture(
            SimultaneousGesture(
                DragGesture(minimumDistance: 3)
                    .updating($dragOffset) { value, state, _ in
                        state = value.translation
                        self.node.isDragging = true
                        self.node.offset = self.offset + self.dragOffset
                    }
                    .onEnded { value in
                        self.offset.width += value.translation.width
                        self.offset.height += value.translation.height

                        self.node.offset = self.offset
                        self.node.isDragging = false
                    },
                TapGesture(count: 1)
                    .onEnded({ _ in self.node.isSelected.toggle() })
            )
        )
    }

}

#Preview {
    @Previewable @State var node = MathNode()
    @Previewable @State var graph = {
        var g = Graph()
        g.addNode(MathNode())
        return g
    }()

    NodeView(node: node).environment(graph)
}
