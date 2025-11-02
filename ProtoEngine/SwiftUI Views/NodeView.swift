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
                    Text("\(node.label)")
                        .font(.title)
                        .bold()
                        .frame(maxHeight: 20)
                        .padding(.horizontal, 30)
                    
                    ForEach(node.inputs, id: \.id) { input in
                        HStack {
                            Circle().size(width: 20, height: 20).frame(
                                width: 20,
                                height: 20,
                            ).padding(.horizontal, 10)
                            Text("Label").font(.caption)
                        }.frame(width: 200, height: 20, alignment: .leading)
                    }
                    Spacer(minLength: 0)
                }
                .frame(width: 200, height: 150, alignment: .leading)
                
                VStack(alignment: .trailing, spacing: 20) {
                    Spacer()
                    ForEach(node.outputs, id: \.id) { input in
                        HStack {
                            Text("Label").font(.caption)
                            Circle().size(width: 20, height: 20).frame(
                                width: 20,
                                height: 20,
                            ).padding(.horizontal, 10)
                        }.frame(width: 200, height: 20, alignment: .trailing)
                    }.padding(.vertical, 5)
                    Spacer()
                }
                .frame(width: 200, height: 150, alignment: .trailing)
            }.padding(.vertical, 25)
        }
        .background(Color.black)
        .frame(width: 200, height: 170)
        .cornerRadius(10)
        .offset(
            self.isDragging
            ? CGSize(
                width: self.offset.width + self.dragOffset.width,
                height: self.offset.height + self.dragOffset.height
            )
            : self.offset
        )
        .gesture(
            SimultaneousGesture(
                DragGesture(minimumDistance: 1)
                    .updating($dragOffset) { value, state, _ in
                        state = value.translation
                    }
                    .onEnded { value in
                        self.offset.width += value.translation.width
                        self.offset.height += value.translation.height
                        
                        isDragging = false
                        print("Dragged node \(String(describing: node.id))")
                    }
                ,
                TapGesture(count: 1)
                    .onEnded({_ in self.isSelected.toggle()})
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
