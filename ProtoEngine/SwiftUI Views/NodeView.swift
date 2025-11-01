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
    @Binding var node: Node

    var body: some View {
        ZStack {
            VStack(
                alignment: .leading,
                spacing: 20,
            ) {
                Text("\(node.label)")
                    .font(.title)
                    .frame(maxHeight: 20)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 5)
            }
            .frame(width: 200, height: 100, alignment: .leading)
        }
        .background(Color.black.opacity(0.7))
        .frame(width: 200, height: 100)
        .cornerRadius(10)
        .gesture(
            TapGesture(count: 1)
                .onEnded({ value in
                    print("Tapped node \(String(describing: node.id))")
                })
        )
        .gesture(
            DragGesture(minimumDistance: 1)
                .onEnded { value in
                    print("Dragged node \(String(describing: node.id))")
                }
        )
    }
}

#Preview {
    @Previewable @State var node = MathNode()
    NodeView(node: $node.toAny())
}
