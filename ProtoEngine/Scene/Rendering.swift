//
//  Rendering.swift
//  ProtoEngine
//
//  Created by Milton Montiel on 29/08/25.
//
import MetalKit

extension Model {
    func render(encoder: MTLRenderCommandEncoder) {
        for mesh in meshes {
            for (index, vertexBuffer) in mesh.vertexBuffers.enumerated() {
                encoder.setVertexBuffer(vertexBuffer, offset: 0, index: index)
            }

            for submesh in mesh.submeshes {
                var material = submesh.material
                encoder.setFragmentBytes(
                    &material,
                    length: MemoryLayout<Material>.stride,
                    index: MaterialBuffer.index
                )

                encoder.setFragmentTexture(
                    submesh.textures.baseColor,
                    index: BaseColor.index
                )

                encoder.setFragmentTexture(
                    submesh.textures.normal,
                    index: NormalTexture.index
                )

                encoder.setFragmentTexture(
                    submesh.textures.roughness,
                    index: RoughnessTexture.index
                )

                encoder.setFragmentTexture(
                    submesh.textures.metallic,
                    index: MetallicTexture.index
                )

                encoder.setFragmentTexture(
                    submesh.textures.aoTexture,
                    index: AOTexture.index
                )

                encoder.drawIndexedPrimitives(
                    type: .triangle,
                    indexCount: submesh.indexCount,
                    indexType: submesh.indexType,
                    indexBuffer: submesh.indexBuffer,
                    indexBufferOffset: submesh.indexBufferOffset
                )
            }
        }
    }
}
