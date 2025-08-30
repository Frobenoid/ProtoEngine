//
//  Model.swift
//  ProtoEngine
//
//  Created by Milton Montiel on 29/08/25.
//

import MetalKit

class Model : Transformable {
    var transform = Transform()
    
    var name: String = "Untitled Model"
    var tiling: UInt32 = 1
    var objectId: UInt32 = 0
    
    var meshes: [Mesh] = []
    init() {}
}

extension Model {
    func setTexture(name: String, type: TextureIndices) {
        // TODO: Implement this!!!
    }
}
