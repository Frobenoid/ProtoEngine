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

    @State private var scrollOffset: CGPoint = .zero
    @State private var hitTestEnable = true
    @State private var showNodes: Bool = true
    //    @State private var evaluator: Graph.Evaluator

    var body: some View {
        ZStack {
            ProtoMetalView().environment(scene).allowsHitTesting(true)
            ScrollView([.horizontal, .vertical]) {
                NodeCanvas()
                    .frame(width: 2000, height: 2000)
                    .allowsHitTesting(self.hitTestEnable)
                    .environment(graph)
            }
            .opacity(showNodes ? 1 : 0)
            .transition(.opacity)
            .defaultScrollAnchor(UnitPoint(x: 0.5, y: 0.5))
            .onScrollGeometryChange(for: CGPoint.self) {
                geo in

                let center = CGPoint(
                    x: geo.contentSize.width / 2,
                    y: geo.contentSize.height / 2
                )

                return center
            } action: { oldScrollOffset, newScrollOffset in
                self.scrollOffset = newScrollOffset
            }.onScrollPhaseChange {
                old,
                new in
                self.hitTestEnable = !new.isScrolling
            }
            PopUpMenus(
                activeMenus: $activeMenus,
                showNodes: $showNodes,
                scene: $scene,
                cameraType: $cameraType
            )
            .environment(graph)
        }
    }
}

#Preview {
    ContentView()
}
