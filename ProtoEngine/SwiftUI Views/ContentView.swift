//
//  ContentView.swift
//  ProtoEngine
//
//  Created by Milton Montiel on 29/08/25.
//

import SwiftUI

struct ContentView: View {
    @State private var scene = ProtoScene()

    var body: some View {
        VStack {
            ProtoMetalView().environment(scene)
            Button("Test") {
                $scene.wrappedValue.lighting.ambientLight.color = .random(in: 0...1)
                print(scene.lighting.ambientLight.color)
            }
        }
    }
}

#Preview {
    ContentView()
}
