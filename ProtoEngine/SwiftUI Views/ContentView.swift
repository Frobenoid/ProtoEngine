//
//  ContentView.swift
//  ProtoEngine
//
//  Created by Milton Montiel on 29/08/25.
//

import QGraph
import SwiftUI

struct ActiveMenus {
    var showLightMenu: Bool = false
    var showCameraMenu: Bool = false
    var showWorldMenu: Bool = false
    var showNodeMenu: Bool = false
}

struct ContentView: View {
    @State private var scene = ProtoScene()
    @State private var activeMenus = ActiveMenus()
    @State private var cameraType: CameraType = .FirstPerson
    @State private var debugLights: Bool = false
    @State private var graph = Graph()

    var body: some View {
        ZStack {
            ProtoMetalView().environment(scene).allowsHitTesting(true)
            ScrollView([.horizontal, .vertical]) {
                NodeCanvas(graph: $graph)
                    .frame(width: 10000, height: 10000)
                    .allowsHitTesting(true)
            }
            .defaultScrollAnchor(UnitPoint(x: 0.5, y: 0.5))
            HStack {
                Spacer()
                VStack {
                    Spacer()
                    VStack {
                        VStack {
                            if activeMenus.showNodeMenu {
                                NodeMenu().environment(graph).transition(
                                    .opacity
                                )
                            }
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
                                activeMenus: $activeMenus
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

#Preview {
    ContentView()
}
