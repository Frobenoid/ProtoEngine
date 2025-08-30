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
        depthStencilState = Self.buildDepthStencilState()
    }

    mutating func resize(view: MTKView, size: CGSize) {

    }

    func draw(
        commandBuffer: MTLCommandBuffer,
        scene: ProtoScene,
        uniforms: Uniforms
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

        // MARK: - Model rendering.
        for model in scene.models {
            model.render(encoder: renderEncoder, uniforms: uniforms)
        }

        renderEncoder.endEncoding()
    }
}
