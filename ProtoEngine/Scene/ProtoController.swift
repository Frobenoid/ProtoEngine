//
//  ProtoController.swift
//  ProtoEngine
//
//  Created by Milton Montiel on 29/08/25.
//

import MetalKit
import SwiftUI

class ProtoController: NSObject {
    var scene: ProtoScene
    var renderer: ProtoRenderer

    var lastTime: Double = CFAbsoluteTime()

    init(metalView: MTKView, scene: ProtoScene) {
        renderer = ProtoRenderer(metalView: metalView)
        self.scene = scene
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
        // MARK: - Time information
        let currentTime = CFAbsoluteTimeGetCurrent()
        let deltaTime = Float(currentTime - lastTime)
        lastTime = currentTime
        scene.update(deltaTime: deltaTime)
        
        renderer.draw(scene: scene, in: view)
    }

}
