//
//  TextureController.swift
//  ProtoEngine
//
//  Created by Milton Montiel on 29/08/25.
//

import MetalKit

enum TextureController {
    static var textures: [String: MTLTexture] = [:]

    static func loadTexture(texture: MDLTexture, name: String) -> MTLTexture? {
        if let texture = textures[name] {
            return texture
        }
        let textureLoader = MTKTextureLoader(device: ProtoRenderer.device)
        let textureLoaderOptions: [MTKTextureLoader.Option: Any] =
            [
                .origin: MTKTextureLoader.Origin.bottomLeft,
                .generateMipmaps: true,
            ]
        let texture = try? textureLoader.newTexture(
            texture: texture,
            options: textureLoaderOptions
        )
        textures[name] = texture
        return texture
    }

    static func loadTexture(name: String) -> MTLTexture? {
        if let texture = textures[name] {
            return texture
        }
        let textureLoader = MTKTextureLoader(device: ProtoRenderer.device)
        let texture: MTLTexture?
        texture = try? textureLoader.newTexture(
            name: name,
            scaleFactor: 1.0,
            bundle: Bundle.main,
            options: nil
        )
        if texture != nil {
            print("loaded texture: \(name)")
            textures[name] = texture
        }
        return texture
    }
}
