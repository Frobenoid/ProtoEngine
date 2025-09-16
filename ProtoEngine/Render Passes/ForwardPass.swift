//
//  ForwardPass.swift
//  ProtoEngine
//
//  Created by Milton Montiel on 29/08/25.
//

import MetalKit

struct ForwardPass: RenderPass {
    var label = "Forward Render Pass"
    var descriptor: MTLRenderPassDescriptor?

    var pipelineState: MTLRenderPipelineState
    var depthStencilState: MTLDepthStencilState?

    init(view: MTKView) {
        pipelineState = PipelinesStates.createForwardPSO(
            colorPixelFormat: view.colorPixelFormat
        )
        depthStencilState = ProtoRenderer.buildDepthStencilState()
    }

    mutating func resize(view: MTKView, size: CGSize) {

    }

    func draw(
        commandBuffer: MTLCommandBuffer,
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
        renderEncoder.setDepthStencilState(depthStencilState)
        renderEncoder.setRenderPipelineState(pipelineState)

        // MARK: - Light rendering.
        var lights: [Light] = scene.lighting.lights

        renderEncoder.setFragmentBytes(
            &lights,
            length: MemoryLayout<Light>.stride * lights.count,
            index: LightBuffer.index
        )

        // MARK: - Model rendering.
        for model in scene.models {
            model.render(
                encoder: renderEncoder,
                uniforms: uniforms,
                params: params
            )
        }

        // MARK: - Light debug rendering.
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
                params: params
            )
        }
    }

}
