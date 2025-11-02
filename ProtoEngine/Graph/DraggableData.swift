//
//  DraggableData.swift
//  ProtoEngine
//
//  Created by Milton Montiel on 01/11/25.
//

import Foundation
import SwiftUI
import UniformTypeIdentifiers

struct DraggableData: Codable {
    let socketID: SocketID
    let sourceNodeID: NodeID
}

extension DraggableData: Transferable {
    static var transferRepresentation: some TransferRepresentation {
        CodableRepresentation(contentType: .draggableData)
    }
}

extension UTType {
    static var draggableData: UTType {
        UTType(exportedAs: "com.frobenoid.draggableData")
    }
}
