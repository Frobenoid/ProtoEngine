//
//  MenuBar.swift
//  ProtoEngine
//
//  Created by Milton Montiel on 01/11/25.
//

import SwiftUI

struct MenuBar: View {
    @Binding var activeMenus: ActiveMenus
    
    var body: some View {
        HStack {
            Button {
                withAnimation {
                    activeMenus.showCameraMenu.toggle()
                }
            } label: {
                Label("Camera", systemImage: "camera.circle").font(.title)
                    .labelStyle(.iconOnly)
                    .padding(9)

            }.background().cornerRadius(10)

            Button {
                withAnimation {
                    activeMenus.showLightMenu.toggle()
                }
            } label: {
                Label("Lighting", systemImage: "lightbulb.max").font(.title)
                    .labelStyle(.iconOnly)
                    .padding(5)
            }.background().cornerRadius(10)

            Button {
                withAnimation {
                    activeMenus.showWorldMenu.toggle()
                }
            } label: {
                Label("Lighting", systemImage: "globe").font(.title)
                    .labelStyle(.iconOnly)
                    .padding(9)
            }.background().cornerRadius(10)

            Button {
                withAnimation {
                    activeMenus.showNodeMenu.toggle()
                }
            } label: {
                Label("Lighting", systemImage: "cable.coaxial").font(.title)
                    .labelStyle(.iconOnly)
                    .padding(9)
            }.background().cornerRadius(10)
        }
    }
}

#Preview {
    @Previewable @State var activeMenus = ActiveMenus()
    MenuBar(
        activeMenus: $activeMenus,

    )
}
