//
//  WireframePass.swift
//  ProtoEngine
//
//  Created by Milton Montiel on 20/09/25.
//

import MetalKit

struct WireframePass: RenderPass {
    var label = "Wireframe Debugging Pass"
    var descriptor: MTLRenderPassDescriptor?

    var pipelineState: MTLRenderPipelineState
    var dephtStencilState: MTLDepthStencilState?

    init(view: MTKView) {
        pipelineState = PipelinesStates.createWireframePSO(
            colorPixelFormat: view.colorPixelFormat
        )
        dephtStencilState = ProtoRenderer.buildDepthStencilState()
    }

    mutating func resize(view: MTKView, size: CGSize) {
    }

    func draw(
        commandBuffer: any MTLCommandBuffer,
        scene: ProtoScene,
        uniforms: Uniforms,
        params: Params
    ) {
        guard
            let descriptor = descriptor,
            let renderEncoder = commandBuffer.makeRenderCommandEncoder(
                descriptor: descriptor
            )
        else {
            return
        }

        renderEncoder.label = label
        renderEncoder.setDepthStencilState(dephtStencilState)
        renderEncoder.setRenderPipelineState(pipelineState)

        // MARK: - Light wireframe rendering.
        var lights: [Light] = scene.lighting.lights

        renderEncoder.setFragmentBytes(
            &lights,
            length: MemoryLayout<Light>.stride * lights.count,
            index: LightBuffer.index
        )

        if scene.showDebugLights {
            for light in scene.lighting.lights {
                lightingDebugDraw(
                    light: light,
                    encoder: renderEncoder,
                    uniforms: uniforms,
                    params: params
                )
            }
        }

        renderEncoder.endEncoding()
    }

    func lightingDebugDraw(
        light: Light,
        encoder: MTLRenderCommandEncoder,
        uniforms: Uniforms,
        params: Params
    ) {
        if light.type.rawValue == 2 {
            var sphere = Model(name: "Sphere", primitiveType: .sphere)
            sphere.transform.position = light.position
            sphere.scale *= 0.1

            sphere.render(
                encoder: encoder,
                uniforms: uniforms,
                params: params,
                primitiveType: .line
            )
        }
    }
}

struct LightDebugPass: RenderPass {
    var label = "Light Debug Pass"
    var descriptor: MTLRenderPassDescriptor?

    var pipelineState: MTLRenderPipelineState
    var depthStencilState: MTLDepthStencilState?

    var debugTexture: MTLTexture?

    mutating func resize(view: MTKView, size: CGSize) {
        debugTexture = Self.makeTexture(
            size: size,
            pixelFormat: view.colorPixelFormat,
            label: "Debug Texture"
        )
    }

    func draw(
        commandBuffer: any MTLCommandBuffer,
        scene: ProtoScene,
        uniforms: Uniforms,
        params: Params
    ) {
        guard let descriptor = descriptor else {
            return
        }

        descriptor.colorAttachments[0].texture = debugTexture
        descriptor.colorAttachments[0].loadAction = .clear
        descriptor.colorAttachments[0].storeAction = .store
        guard
            let renderEncoder = commandBuffer.makeRenderCommandEncoder(
                descriptor: descriptor
            )
        else {
            return
        }

        if scene.showDebugLights {
            for light in scene.lighting.lights {
                if light.type.rawValue == 2 {
                    var sphere = Model(name: "Sphere", primitiveType: .sphere)
                    sphere.transform.position = light.position
                    sphere.scale *= 0.1

                    sphere.render(
                        encoder: renderEncoder,
                        uniforms: uniforms,
                        params: params,
                        primitiveType: .line
                    )
                }

            }
        }

        renderEncoder.endEncoding()
    }
}
