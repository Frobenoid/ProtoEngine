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

    var body: some View {
        VStack {

            Text("Ambient Light Settings").font(.title)
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
        }.padding(10)
            .frame(width: 300)
    }
}

#Preview {
    @Previewable @State var light = Lighting.buildDefaultLight()
    LightMenu(light: $light)
}

extension Color {
    func toFloat3() -> float3? {
        guard let cgColor = self.cgColor else {
            return nil
        }

        // Convet to the sRGB color space
        let sRGBColor = cgColor.converted(
            to: CGColorSpaceCreateDeviceRGB(),
            intent: .relativeColorimetric,
            options: nil
        )

        guard let components = sRGBColor?.components,
            components.count >= 3
        else {
            return nil
        }

        let red = Float(components[0])
        let green = Float(components[1])
        let blue = Float(components[2])

        return float3(red, green, blue)
    }
}
