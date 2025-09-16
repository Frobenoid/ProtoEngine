//
//  ContentView.swift
//  ProtoEngine
//
//  Created by Milton Montiel on 29/08/25.
//

import SwiftUI

struct ContentView: View {
    @State private var scene = ProtoScene()
    @State private var showLightMenu: Bool = false
    @State private var showCameraMenu: Bool = false
    @State private var cameraType: CameraType = .FirstPerson
    @State private var debugLights: Bool = false

    var body: some View {
        ZStack {
            ProtoMetalView().environment(scene)
            HStack {
                Spacer()
                VStack {
                    Spacer()
                    VStack {

                        VStack {
                            if showLightMenu {
                                LightMenu(
                                    light: $scene.lighting.lights[
                                        AmbientLight.index
                                    ],
                                    debugLights: $scene.showDebugLights
                                ).transition(.opacity)
                            }

                            if showCameraMenu {
                                CameraSettingMenu(cameraType: $cameraType)
                                    .onChange(of: cameraType) {
                                        scene.setCameraType(
                                            to: cameraType
                                        )

                                    }.transition(.opacity)
                            }
                        }

                        HStack {
                            Spacer()
                            MenuBar(
                                lightMenuIsActive: $showLightMenu,
                                cameraSettingsIsActive: $showCameraMenu
                            )
                        }
                    }
                    .frame(width: 300)
                    .padding(10)
                }
            }
        }
    }
}

struct MenuBar: View {
    @Binding var lightMenuIsActive: Bool
    @Binding var cameraSettingsIsActive: Bool

    var body: some View {
        HStack {
            Button {
                withAnimation {
                    cameraSettingsIsActive.toggle()
                }
            } label: {
                Label("Camera", systemImage: "camera.circle").font(.title)
                    .labelStyle(.iconOnly)
                    .padding(9)

            }.background().cornerRadius(10)

            Button {
                withAnimation {
                    lightMenuIsActive.toggle()
                }
            } label: {
                Label("Lighting", systemImage: "lightbulb.max").font(.title)
                    .labelStyle(.iconOnly)
                    .padding(5)
            }.background().cornerRadius(10)

        }
    }
}
#Preview {
    ContentView()
}
