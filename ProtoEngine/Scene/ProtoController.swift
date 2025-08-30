//
//  ProtoController.swift
//  ProtoEngine
//
//  Created by Milton Montiel on 29/08/25.
//

import MetalKit

class ProtoController: NSObject {
    var scene: ProtoScene
    var renderer: ProtoRenderer

    init(metalView: MTKView) {
        renderer = ProtoRenderer(metalView: metalView)
        scene = ProtoScene()
        super.init()
        metalView.delegate = self
        mtkView(metalView, drawableSizeWillChange: metalView.drawableSize)
    }
}

extension ProtoController: MTKViewDelegate {
    /// Passes down view information to the scene and the renderer. This function is called
    /// on view change.lastTime
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
        scene.update(size: size)
        renderer.mtkView(view, drawableSizeWillChange: size)
    }

    /// Called each frame.
    func draw(in view: MTKView) {
        let currentTime = CFAbsoluteTimeGetCurrent()
        let deltaTime = (currentTime )
        scene.update(deltaTime: Float(deltaTime))
        renderer.draw(scene: scene, in: view)
    }

}
