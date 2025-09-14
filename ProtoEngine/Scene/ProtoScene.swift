//
//  ProtoScene.swift
//  ProtoEngine
//
//  Created by Milton Montiel on 29/08/25.
//

import Foundation

/// Stores scene information such as models and cameras.
@Observable
class ProtoScene {
    var models: [Model] = []
    var camera: any Camera
    var lighting = Lighting()

    var model: Model = Model(name: "gizmo.usdc")
    var axo: Model = Model(name: "Axo.usdz")
    var axo2 = Model(name: "Axo_2.usdz")

    var defaultView: Transform {
        Transform(
            position: [0, 0, -5])
    }

    func update(size: CGSize) {
        camera.update(size: size)
    }

    func update(deltaTime: Float) {
        camera.update(deltaTime: deltaTime)
    }

    init() {
        camera = FPCamera()

        axo.rotation.y = 90
        axo.scale *= 0.1
        axo2.scale *= 0.0001
        axo2.transform.position.z = -2
        axo2.transform.position.y = -0.25

        camera.transform = defaultView
        models = [axo, axo2]
    }

    func setCameraType(to type: CameraType) {

        var newCamera: any Camera = {
            switch type {
            case .FirstPerson:
                return FPCamera()
            case .ArcBall:
                return ArcballCamera()
            case .Player:
                return PlayerCamera()
            }
        }()

        newCamera.transform = defaultView
        self.camera = newCamera
    }
}
