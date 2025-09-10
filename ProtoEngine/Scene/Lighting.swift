//
//  Lighting.swift
//  ProtoEngine
//
//  Created by Milton Montiel on 07/09/25.
//

struct Lighting {
    let sunlight: Light = {
        var light = Self.buildDefaultLight()
        light.position = [1, 2, -2]
        return light
    }()

    var ambientLight: Light = {
        var light = Self.buildDefaultLight()
        light.color = [0.05, 0.1, 0]
        light.type = Ambient
        return light
    }()

    let redLight: Light = {
        var light = Self.buildDefaultLight()
        light.type = Point
        light.position = [-0.8, 0.1, -0.1]
        light.color = [1, 0, 0]
        light.attenuation = [0.5, 2, 1]
        return light
    }()

    lazy var spotLight: Light = {
        var light = Self.buildDefaultLight()
        light.type = Spot
        light.position = [-0.6, 0.6, -1]
        light.color = [1, 0, 1]
        light.attenuation = [1, 0.5, 0]
        light.coneAngle = Float(40).degreesToRadians
        light.coneDirection = [0.5, -0.7, 1]
        light.coneAttenuation = 8
        return light
    }()

    var lights: [Light] = []

    init() {
        lights.append(ambientLight)
        lights.append(sunlight)
        lights.append(redLight)
        lights.append(spotLight)
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
