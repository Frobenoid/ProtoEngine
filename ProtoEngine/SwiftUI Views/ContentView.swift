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
        ZStack {
            ProtoMetalView().environment(scene)
            HStack {
                Spacer()
                VStack {
                    Spacer()
                    LightMenu(light: $scene.lighting.lights[AmbientLight.index])
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
