//
//  ProtoRenderer.swift
//  ProtoEngine
//
//  Created by Milton Montiel on 29/08/25.
//

import MetalKit

class ProtoRenderer: NSObject {
    static var device: MTLDevice!
    static var commandQueue: MTLCommandQueue!
    static var library: MTLLibrary!

    // MARK: - Render passes
    var forwardPass: ForwardPass

    // Uniforms
    var uniforms = Uniforms()
    
    var lastTime: Double = CFAbsoluteTimeGetCurrent()
    
    init(metalView: MTKView) {
        guard
            let device = MTLCreateSystemDefaultDevice(),
            let commandQueue = device.makeCommandQueue()
        else {
            fatalError("Metal is not supported on this device.")
        }

        Self.device = device
        Self.commandQueue = commandQueue
        metalView.device = device

        // MARK: - Shader function library creation
        let library = device.makeDefaultLibrary()
        Self.library = library

        forwardPass = ForwardPass(view: metalView)

        super.init()
        metalView.clearColor = MTLClearColor(
            red: 0.05,
            green: 0.1,
            blue: 0.16,
            alpha: 1
        )
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
    }

    /// Called each frame from ``ProtoScene``.
    func draw(scene: ProtoScene, in view: MTKView) {
        guard
            let commandBuffer = Self.commandQueue.makeCommandBuffer(),
            let descriptor = view.currentRenderPassDescriptor
        else { return }

        updateUniforms(scene: scene)
        
        // MARK: - Render passes
        forwardPass.descriptor = descriptor
        forwardPass.draw(
            commandBuffer: commandBuffer,
            scene: scene,
            uniforms: uniforms
        )

        guard let drawable = view.currentDrawable else {
            return
        }
        commandBuffer.present(drawable)
        commandBuffer.commit()
    }
}
