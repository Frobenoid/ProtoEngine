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
    var camera = FPCamera()
    
    lazy var sphere: Model = {
        var sphere = Model(name: "Sphere", primitiveType: .sphere)
        sphere.scale = 2
        sphere.meshes[0].submeshes[0].material.baseColor = [0,1,0]
        return sphere
    }()
    
    var defaultView: Transform {
      Transform(
        position: [0,0,-5])
    }

    mutating func update(size: CGSize) {
        
        camera.update(size: size)
    }
    
    mutating func update(deltaTime: Float) {
        
    }
    
    init() {
        camera.transform = defaultView
        models = [sphere]
    }
}
