//
//  ContentView.swift
//  ProtoEngine
//
//  Created by Milton Montiel on 29/08/25.
//

import SwiftUI

struct ActiveMenus {
    var showLightMenu: Bool = false
    var showCameraMenu: Bool = false
    var showWorldMenu: Bool = false
}

struct ContentView: View {
    @State private var scene = ProtoScene()
    @State private var activeMenus = ActiveMenus()
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
                            if activeMenus.showLightMenu {
                                LightMenu(
                                    light: $scene.lighting.lights[
                                        AmbientLight.index
                                    ],
                                    debugLights: $scene.showDebugLights
                                ).transition(.opacity)
                            }
                            if activeMenus.showCameraMenu {
                                CameraSettingMenu(cameraType: $cameraType)
                                    .onChange(of: cameraType) {
                                        scene.setCameraType(
                                            to: cameraType
                                        )

                                    }.transition(.opacity)
                            }
                            if activeMenus.showWorldMenu {
                                WorldSettingsMenu(
                                    light: $scene.lighting.lights[
                                        AmbientLight.index
                                    ]
                                )
                            }
                        }
                        HStack {
                            Spacer()
                            MenuBar(
                                lightMenuIsActive: $activeMenus.showLightMenu,
                                cameraSettingsIsActive: $activeMenus
                                    .showCameraMenu,
                                worldMenuIsActive: $activeMenus.showWorldMenu
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
    @Binding var worldMenuIsActive: Bool

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

            Button {
                withAnimation {
                    worldMenuIsActive.toggle()
                }
            } label: {
                Label("Lighting", systemImage: "globe").font(.title)
                    .labelStyle(.iconOnly)
                    .padding(9)
            }.background().cornerRadius(10)
        }
    }
}
#Preview {
    ContentView()
}
