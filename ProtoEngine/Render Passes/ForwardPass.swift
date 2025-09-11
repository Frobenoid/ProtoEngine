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
//        // Updating lights
//        lights[AmbientLight.index] = scene.lighting.ambientLight

        renderEncoder.setFragmentBytes(
            &lights,
            length: MemoryLayout<Light>.stride * lights.count,
            index: LightBuffer.index
        )

        //        var ambient = scene.lighting.ambientLight
        //        renderEncoder.setFragmentBytes(
        //            &ambient,
        //            length: MemoryLayout<Light>.stride,
        //            index: LightBuffer.index
        //        )

        // MARK: - Model rendering.
        for model in scene.models {
            model.render(
                encoder: renderEncoder,
                uniforms: uniforms,
                params: params
            )
        }

        renderEncoder.endEncoding()
    }
}
