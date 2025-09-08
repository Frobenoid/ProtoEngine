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
    
    let ambientLight: Light = {
        var light = Self.buildDefaultLight()
        light.color = [0.05, 0.1, 0]
        light.type = Ambient
        return light
    }()
    
    var lights: [Light] = []
    
    init() {
        lights.append(sunlight)
        lights.append(ambientLight)
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
