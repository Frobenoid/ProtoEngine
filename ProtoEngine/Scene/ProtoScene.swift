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
    
    lazy var sphere: Model = {
        var sphere = Model(name: "Sphere", primitiveType: .sphere)
        sphere.meshes[0].submeshes[0].material.baseColor = [0.9,0.0,0.9]
        return sphere
    }()
    
    mutating func update(size: CGSize) {
        
    }
    
    mutating func update(deltaTime: Float) {
        
    }
    
    init() {
        models = [sphere]
    }
}
