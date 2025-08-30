//
//  Transform.swift
//  ProtoEngine
//
//  Created by Milton Montiel on 29/08/25.
//

import Foundation

struct Transform {
    var position: float3 = [0, 0, 0]
    var rotation: float3 = [0, 0, 0]
    var scale: Float = 1

    var modelMatrix: matrix_float4x4 {
        let modelMatrix = matrix_identity_float4x4
        return modelMatrix
    }
}

protocol Transformable {
    var transform: Transform { get set }
}

extension Transformable {
    var position: float3 {
        get { transform.position }
        set { transform.position = newValue }
    }
    var rotation: float3 {
        get { transform.rotation }
        set { transform.rotation = newValue }
    }
    var scale: Float {
        get { transform.scale }
        set { transform.scale = newValue }
    }
}
