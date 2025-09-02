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

    lazy var sphere: Model = {
        var sphere = Model(name: "Sphere", primitiveType: .sphere)
        sphere.scale = 2
        sphere.meshes[0].submeshes[0].material.baseColor = [0, 1, 0]
        return sphere
    }()

    lazy var cube: Model = {
        var cube = Model(name: "Cube", primitiveType: .box)
        cube.scale = 2
        cube.meshes[0].submeshes[0].material.baseColor = [1, 0, 0]
        return cube
    }()

    lazy var ico: Model = {
        var ico = Model(name: "Sphere", primitiveType: .ico)
        ico.scale = 1
        ico.meshes[0].submeshes[0].material.baseColor = [0, 0, 1]
        return ico
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
        models = [sphere, cube, ico]
    }
}
