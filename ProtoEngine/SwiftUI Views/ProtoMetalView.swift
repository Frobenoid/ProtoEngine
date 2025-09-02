//
//  ProtoMetalView.swift
//  ProtoEngine
//
//  Created by Milton Montiel on 29/08/25.
//

import MetalKit
import SwiftUI

struct ProtoMetalView: View {
    @State private var metalView = MTKView()
    @State private var controller: ProtoController?
    @Environment(ProtoScene.self) private var scene

    var body: some View {
        ProtoMetalViewRepresentable(metalView: $metalView)
            .onAppear {
                controller = ProtoController(metalView: metalView, scene: scene)
            }
    }
}

struct ProtoMetalViewRepresentable: NSViewRepresentable {
    @Binding var metalView: MTKView

    func makeNSView(context: Context) -> NSView {
        metalView
    }

    func updateNSView(_ nsView: NSView, context: Context) {
        updateMetalView()
    }

    func updateMetalView() {

    }
}

#Preview {
    var scene = ProtoScene()
    
    VStack {
        ProtoMetalView().environment(scene)
        Button("Box") {
            scene.addPrimitive(primitive: .box)
        }
    }.padding()
}
