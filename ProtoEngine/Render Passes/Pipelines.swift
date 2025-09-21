//
//  Pipelines.swift
//  ProtoEngine
//
//  Created by Milton Montiel on 29/08/25.
//

import MetalKit

enum PipelinesStates {
    static func createPSO(descriptor: MTLRenderPipelineDescriptor)
        -> MTLRenderPipelineState
    {
        let pipelineState: MTLRenderPipelineState
        do {
            pipelineState =
                try ProtoRenderer.device.makeRenderPipelineState(
                    descriptor: descriptor
                )
        } catch {
            fatalError(error.localizedDescription)
        }
        return pipelineState
    }

    static func createForwardPSO(colorPixelFormat: MTLPixelFormat)
        -> MTLRenderPipelineState
    {
        let vertexFunction = ProtoRenderer.library?.makeFunction(
            name: "vertex_main"
        )
        let fragmentFunction = ProtoRenderer.library?.makeFunction(
            name: "fragment_main"
        )

        let pipelineDescriptor = MTLRenderPipelineDescriptor()

        pipelineDescriptor.vertexFunction = vertexFunction
        pipelineDescriptor.fragmentFunction = fragmentFunction
        pipelineDescriptor.colorAttachments[0].pixelFormat = colorPixelFormat
        pipelineDescriptor.depthAttachmentPixelFormat = .depth32Float
        pipelineDescriptor.vertexDescriptor = MTLVertexDescriptor.defaultLayout

        return createPSO(descriptor: pipelineDescriptor)
    }

    static func createWireframePSO(colorPixelFormat: MTLPixelFormat)
        -> MTLRenderPipelineState
    {

        let vertexFunction = ProtoRenderer.library?.makeFunction(
            name: "vertex_main"
        )
        let fragmentFunction = ProtoRenderer.library?.makeFunction(
            name: "wireframe_fragment_main"
        )

        let pipelineDescriptor = MTLRenderPipelineDescriptor()

        pipelineDescriptor.vertexFunction = vertexFunction
        pipelineDescriptor.fragmentFunction = fragmentFunction
        pipelineDescriptor.colorAttachments[0].pixelFormat = colorPixelFormat
        pipelineDescriptor.depthAttachmentPixelFormat = .depth32Float
        pipelineDescriptor.vertexDescriptor = MTLVertexDescriptor.defaultLayout

        return createPSO(descriptor: pipelineDescriptor)
    }
}
