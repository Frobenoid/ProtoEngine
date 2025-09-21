//
//  ProtoRenderer.swift
//  ProtoEngine
//
//  Created by Milton Montiel on 29/08/25.
//

import Foundation
import MetalKit

class ProtoRenderer: NSObject {
    static var device: MTLDevice! = {
        guard let device = MTLCreateSystemDefaultDevice() else {
            fatalError("Metal is not supported on this device.")
        }
        return device
    }()

    static var commandQueue: MTLCommandQueue! = {
        guard let commandQueue = device.makeCommandQueue() else {
            fatalError("Could not create command queue.")
        }
        return commandQueue
    }()

    static var library: MTLLibrary! = {
        return device.makeDefaultLibrary()
    }()

    // MARK: - Render passes
    var forwardPass: ForwardPass
    var wireframePass: WireframePass

    // Uniforms
    var uniforms = Uniforms()
    var params = Params()

    var lastTime: Double = CFAbsoluteTimeGetCurrent()

    init(metalView: MTKView) {
        metalView.device = Self.device

        // MARK: - Render pass initialization.
        forwardPass = ForwardPass(view: metalView)
        wireframePass = WireframePass(view: metalView)

        metalView.clearColor = MTLClearColor(
            red: 0.86,
            green: 0.86,
            blue: 0.96,
            alpha: 1
        )

        super.init()

        metalView.depthStencilPixelFormat = .depth32Float
        mtkView(metalView, drawableSizeWillChange: metalView.drawableSize)
    }

    static func buildDepthStencilState() -> MTLDepthStencilState? {
        let descriptor = MTLDepthStencilDescriptor()
        descriptor.depthCompareFunction = .less
        descriptor.isDepthWriteEnabled = true
        return ProtoRenderer.device.makeDepthStencilState(
            descriptor: descriptor
        )
    }
}

extension ProtoRenderer {
    /// Called on view change from ``ProtoScene``
    func mtkView(
        _ view: MTKView,
        drawableSizeWillChange size: CGSize
    ) {
        // MARK: - Render passes resizing
        forwardPass.resize(view: view, size: size)
    }

    func updateUniforms(scene: ProtoScene) {
        uniforms.viewMatrix = scene.camera.viewMatrix
        uniforms.projectionMatrix = scene.camera.projectionMatrix
        params.cameraPosition = scene.camera.position
        params.lightCount = UInt32(scene.lighting.lights.count)
    }

    /// Called each frame from ``ProtoScene``.
    func draw(scene: ProtoScene, in view: MTKView) {
        guard
            let commandBuffer = Self.commandQueue.makeCommandBuffer(),
            let descriptor = view.currentRenderPassDescriptor
        else { return }

        updateUniforms(scene: scene)

        // MARK: - Render passes
        wireframePass.descriptor = descriptor
        wireframePass.draw(
            commandBuffer: commandBuffer,
            scene: scene,
            uniforms: uniforms,
            params: params
        )
        
        forwardPass.descriptor = descriptor
        forwardPass.draw(
            commandBuffer: commandBuffer,
            scene: scene,
            uniforms: uniforms,
            params: params
        )

        // MARK: - Presenting to a drawable
        guard let drawable = view.currentDrawable else {
            return
        }
        commandBuffer.present(drawable)
        commandBuffer.commit()
    }
}
