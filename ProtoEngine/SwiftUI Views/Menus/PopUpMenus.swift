//
//  PopUpMenus.swift
//  ProtoEngine
//
//  Created by Milton Montiel on 02/11/25.
//

import SwiftUI

struct PopUpMenus: View {
    @Environment(Graph.self) var graph
    @Binding var activeMenus: ActiveMenus
    @Binding var showNodes: Bool
    @Binding var scene: ProtoScene
    @Binding var cameraType: CameraType
    
    var body: some View {
        HStack {
            Spacer()
            VStack {
                Spacer()
                VStack {
                    VStack {
                        if activeMenus.showNodeMenu {
                            NodeMenu(showNodes: $showNodes).environment(
                                graph
                            ).transition(
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

