//
//  Lighting.swift
//  ProtoEngine
//
//  Created by Milton Montiel on 07/09/25.
//

struct Lighting {
    let sunlight: Light = {
        var light = Self.buildDefaultLight()
        light.position = [1,2,-2]
        return light
    }()
    
    var lights: [Light] = []
    
    init() {
        lights.append(sunlight)
    }
    
    static func buildDefaultLight() -> Light {
        var light = Light()
        light.position = [0, 0, 0]
        light.color = [1, 1, 1]
        light.specularColor = [0.3, 0.3, 0.3]
        light.attenuation = [1, 0, 0]
        light.type = Sun
        return light
    }
}
