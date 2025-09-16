//
//  CameraSettingMenu.swift
//  ProtoEngine
//
//  Created by Milton Montiel on 13/09/25.
//

import SwiftUI

struct CameraSettingMenu: View {
    @Binding var cameraType: CameraType
    //    @State var scale = 0.5

    var body: some View {
        VStack {
            Text("Camera Settings").font(.title)
            Divider()
            
                Picker("Type", selection: $cameraType) {
                    Text("Arcball").tag(CameraType.ArcBall)
                    Text("Player").tag(CameraType.Player)
                    Text("First Person").tag(CameraType.FirstPerson)
                }.pickerStyle(.segmented)
//            Menu {
//                Button {
//                    cameraType = .ArcBall
//                } label: {
//                    Text("Arcball Camera")
//                }
//                Button {
//                    cameraType = .FirstPerson
//                } label: {
//                    Text("First Person")
//                }
//                Button {
//                    cameraType = .Player
//                } label: {
//                    Text("Player")
//                }
//            } label: {
//                Label("Camera type", systemImage: "camera.aperture")
//            }.menuStyle(.borderedButton)
//
        }
        .padding(10)
        .frame(width: 300)
        .background()
        .cornerRadius(10)
    }
}

#Preview {
    @Previewable @State var cameraType: CameraType = .FirstPerson
    CameraSettingMenu(cameraType: $cameraType)
}
