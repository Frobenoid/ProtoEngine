//
//  Primitive.swift
//  ProtoEngine
//
//  Created by Milton Montiel on 29/08/25.
//

import MetalKit

enum Primitive {
    case plane, sphere, box, ico
}

extension Model {
    static func createMesh(primitiveType: Primitive) -> MDLMesh {
        let allocator = MTKMeshBufferAllocator(device: ProtoRenderer.device)
        switch primitiveType {
        case .plane:
            return MDLMesh(
                planeWithExtent: [1, 1, 1],
                segments: [4, 4],
                geometryType: .triangles,
                allocator: allocator
            )
        case .sphere:
            return MDLMesh(
                sphereWithExtent: [1, 1, 1],
                segments: [30, 30],
                inwardNormals: false,
                geometryType: .triangles,
                allocator: allocator
            )
        case .box:
            return MDLMesh(
                boxWithExtent: [1, 1, 1],
                segments: [4, 4,4 ],
                inwardNormals: false,
                geometryType: .lines,
                allocator: allocator
            )
        case .ico:
            return MDLMesh(
                icosahedronWithExtent: [1, 1, 1],
                inwardNormals: false,
                geometryType: .lines,
                allocator: allocator
            )

        }
    }

    convenience init(name: String, primitiveType: Primitive) {
        let mdlMesh = Self.createMesh(primitiveType: primitiveType)
        mdlMesh.vertexDescriptor = MDLVertexDescriptor.defaultLayout
        mdlMesh.addTangentBasis(
            forTextureCoordinateAttributeNamed:
                MDLVertexAttributeTextureCoordinate,
            normalAttributeNamed: MDLVertexAttributeTangent,
            tangentAttributeNamed: MDLVertexAttributeBitangent
        )

        let mtkMesh = try! MTKMesh(mesh: mdlMesh, device: ProtoRenderer.device)
        let mesh = Mesh(mdlMesh: mdlMesh, mtkMesh: mtkMesh)
        self.init()
        self.meshes = [mesh]
        self.name = name

    }
}
