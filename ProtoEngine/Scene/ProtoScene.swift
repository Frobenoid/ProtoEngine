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
    var camera = PlayerCamera()

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
        camera.transform = defaultView
        models = []
    }
}

extension ProtoScene {
    func addPrimitive(primitive: Primitive) {
        let primitiveModel = Model(name: "Primitive", primitiveType: primitive)
        self.models.append(primitiveModel)
    }
}
