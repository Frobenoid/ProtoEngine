//
//  ProtoScene.swift
//  ProtoEngine
//
//  Created by Milton Montiel on 29/08/25.
//

import Foundation

/// Stores scene information such as models and cameras.
struct ProtoScene {
    var models: [Model] = []
    var camera = PlayerCamera()
    let lighting = Lighting()
    
    lazy var model: Model = {
        Model(name: "gizmo.usdc")
    }()

    var defaultView: Transform {
        Transform(
            position: [0, 0, -5])
    }

    mutating func update(size: CGSize) {
        camera.update(size: size)
    }

    mutating func update(deltaTime: Float) {
        camera.update(deltaTime: deltaTime)
    }

    init() {
        camera.transform = defaultView
        models = [model]
    }
}
