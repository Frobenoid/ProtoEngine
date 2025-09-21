//
//  LightMenu.swift
//  ProtoEngine
//
//  Created by Milton Montiel on 11/09/25.
//

import SwiftUI
import simd

struct LightMenu: View {
    @Binding var light: Light
    @State var color: CGColor = .white
    @Binding var debugLights: Bool

    var body: some View {
        VStack {
            Text("Lighting").font(.title)
            Divider()
            Text("Debugging Options").font(.title2)
            Toggle("Show Lights", isOn: $debugLights).toggleStyle(.switch)

        }.padding(10)
            .frame(width: 300)
            .background()
            .cornerRadius(10)
    }
}

#Preview {
    @Previewable @State var light = Lighting.buildDefaultLight()
    @Previewable @State var debugLights: Bool = false
    LightMenu(light: $light, debugLights: $debugLights)
}
