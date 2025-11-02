//
//  SocketAnchorKey.swift
//  ProtoEngine
//
//  Created by Milton Montiel on 01/11/25.
//

import Foundation
import SwiftUI

struct Test: Hashable {
    var a: Int
    var b: Int
}

public struct SocketAnchorKey: PreferenceKey {
    public typealias Value = [UUID: Anchor<CGPoint>]
    public static var defaultValue: [UUID: Anchor<CGPoint>] = [:]

    public static func reduce(
        value: inout [UUID: Anchor<CGPoint>],
        nextValue: () -> [UUID: Anchor<CGPoint>]
    ) {
        value.merge(nextValue(), uniquingKeysWith: { $1 })
    }
}
