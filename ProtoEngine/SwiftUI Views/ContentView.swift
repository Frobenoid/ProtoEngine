//
//  ContentView.swift
//  ProtoEngine
//
//  Created by Milton Montiel on 29/08/25.
//

import SwiftUI

struct ContentView: View {
    @State private var scene = ProtoScene()
    @State private var scene2 = ProtoScene()
    
    var body: some View {
        VStack {
            ProtoMetalView().environment(scene)
            ProtoMetalView().environment(scene2)
        }
        Button("Scene 1 Add Box") {
            scene.addPrimitive(primitive: .box)
        }
        Button("Scene 2 Add Sphere") {
            scene2.addPrimitive(primitive: .sphere)
        }
    }
}

#Preview {
    ContentView()
}
