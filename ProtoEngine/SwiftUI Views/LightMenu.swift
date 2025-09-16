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
            Text("Lighting Settings").font(.title)
            Divider()
            Text("Ambient Light").font(.title2)
            HStack {
                ColorPicker("Color", selection: $color).onChange(
                    of: color,
                    {

                        guard let components = color.components,
                            components.count >= 3
                        else {
                            return
                        }

                        light.color = float3(
                            x: Float(components[0]),
                            y: Float(components[1]),
                            z: Float(components[2])
                        )
                    }

                ).onAppear {
                    color = CGColor(
                        red: CGFloat(light.color.x),
                        green: CGFloat(light.color.y),
                        blue: CGFloat(light.color.z),
                        alpha: 1
                    )
                }
                Spacer()
            }
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
