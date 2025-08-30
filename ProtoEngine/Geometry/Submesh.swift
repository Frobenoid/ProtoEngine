//
//  Submesh.swift
//  ProtoEngine
//
//  Created by Milton Montiel on 29/08/25.
//

import MetalKit

struct Submesh {
    let indexCount: Int
    let indexType: MTLIndexType
    let indexBuffer: MTLBuffer
    let indexBufferOffset: Int

    struct Textures {
        var baseColor: MTLTexture?
        var normal: MTLTexture?
        var roughness: MTLTexture?
        var metallic: MTLTexture?
        var aoTexture: MTLTexture?
    }

    var textures: Textures
    var material: Material
}

extension MDLMaterialProperty {
    fileprivate var textureName: String {
        stringValue ?? UUID().uuidString
    }
}

extension MDLMaterial {
    fileprivate func texture(type semantic: MDLMaterialSemantic) -> MTLTexture?
    {
        if let property = property(with: semantic),
            property.type == .texture,
            let mdlTexture = property.textureSamplerValue?.texture
        {
            return TextureController.loadTexture(
                texture: mdlTexture,
                name: property.textureName
            )
        }
        return nil
    }
}

extension Submesh.Textures {
    fileprivate init(material: MDLMaterial?) {
        baseColor = material?.texture(type: .baseColor)
    }
}

extension Submesh {
    init(mdlSubmesh: MDLSubmesh, mtkSubmesh: MTKSubmesh) {
        indexCount = mtkSubmesh.indexCount
        indexType = mtkSubmesh.indexType
        indexBuffer = mtkSubmesh.indexBuffer.buffer
        indexBufferOffset = mtkSubmesh.indexBuffer.offset
        textures = Textures(material: mdlSubmesh.material)
        material = Material(material: mdlSubmesh.material)
    }
}

extension Material {
    fileprivate init(material: MDLMaterial?) {
        self.init()
        if let baseColor = material?.property(with: .baseColor),
            baseColor.type == .float3
        {
            self.baseColor = baseColor.float3Value
        }
        if let roughness = material?.property(with: .roughness),
            roughness.type == .float
        {
            self.roughness = roughness.floatValue
        }
        if let metallic = material?.property(with: .metallic),
            metallic.type == .float
        {
            self.metallic = metallic.floatValue
        }
        self.ambientOcclusion = 1
    }
}
