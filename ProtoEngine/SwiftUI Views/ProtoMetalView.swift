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

    var body: some View {
        ProtoMetalViewRepresentable(metalView: $metalView)
            .onAppear {
                controller = ProtoController(metalView: metalView)
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
    VStack {
        Text("Metal View")
        ProtoMetalView()
    }
}
