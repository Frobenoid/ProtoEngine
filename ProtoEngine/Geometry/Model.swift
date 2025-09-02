//
//  Model.swift
//  ProtoEngine
//
//  Created by Milton Montiel on 29/08/25.
//

import MetalKit

class Model: Transformable {
    var transform = Transform()

    var name: String = "Untitled Model"
    var tiling: UInt32 = 1
    var objectId: UInt32 = 0

    var meshes: [Mesh] = []
    init() {}

    init(name: String) {
        guard
            let assetURL = Bundle.main.url(
                forResource: name,
                withExtension: nil
            )
        else {
            fatalError("Model \(name) not found")
        }

        let allocator = MTKMeshBufferAllocator(device: ProtoRenderer.device)
        let asset = MDLAsset(
            url: assetURL,
            vertexDescriptor: .defaultLayout,
            bufferAllocator: allocator
        )
        asset.loadTextures()

        var mtkMeshes: [MTKMesh] = []
        let mdlMeshes =
            asset.childObjects(of: MDLMesh.self) as? [MDLMesh] ?? []
        _ = mdlMeshes.map { mdlMesh in
            mdlMesh.addTangentBasis(
                forTextureCoordinateAttributeNamed:
                    MDLVertexAttributeTextureCoordinate,
                normalAttributeNamed: MDLVertexAttributeTangent,
                tangentAttributeNamed: MDLVertexAttributeBitangent
            )

            mtkMeshes.append(
                try! MTKMesh(mesh: mdlMesh, device: ProtoRenderer.device)
            )
        }
        meshes = zip(mdlMeshes, mtkMeshes).map {
            Mesh(mdlMesh: $0.0, mtkMesh: $0.1)
        }
        
        self.name = name
    }
}

extension Model {
    func setTexture(name: String, type: TextureIndices) {
        if let texture = TextureController.loadTexture(name: name) {
            switch type {
            case BaseColor:
                meshes[0].submeshes[0].textures.baseColor = texture
            default: break
            }
        }
    }
}
