//
//  Socket.swift
//  ProtoEngine
//
//  Created by Milton Montiel on 01/11/25.
//

import Foundation

typealias SocketID = Int
typealias NodeID = Int

struct Link: Hashable {

    var sourceNode: NodeID
    let sourceSocket: SocketID
    let destinationNode: NodeID
    let destinationSocket: SocketID
}

protocol Socket {
    var id: SocketID? { get set }

    // Untyped value modifiers.
    mutating func setUntypedCurrentValue(to value: Any)
    /// Gets the current value casted to ``Any``.
    mutating func untypedCurrentValue() -> Any

    func getNeighbors() -> Set<Link>
    func connect(to: NodeID, atInput: SocketID)
    func disconnect(link: Link)
}

class InSocket<T>: Socket {
    var currentValue: T
    var defaultValue: T

    var id: SocketID?

    func setUntypedCurrentValue(to value: Any) {
        self.currentValue = value as! T
    }

    func untypedCurrentValue() -> Any {
        return currentValue as Any
    }

    func getNeighbors() -> Set<Link> {
        return []
    }

    init(defaultValue: T) {
        self.currentValue = defaultValue
        self.defaultValue = defaultValue
    }

    func connect(to: NodeID, atInput: SocketID) {
        print("CALLED CONNECT ON AN INPUT SOCKET")
    }

    func disconnect(link: Link) {
        print("CALLED DISCONNECT ON AN INPUT SOCKET")
    }
}

class OutSocket<T>: Socket {
    var currentValue: T
    var defaultValue: T

    var id: SocketID?

    var neighbors: Set<Link> = []

    func setUntypedCurrentValue(to value: Any) {
        self.currentValue = value as! T
    }

    func untypedCurrentValue() -> Any {
        return currentValue as Any
    }

    func getNeighbors() -> Set<Link> {
        return neighbors
    }

    func connect(to: NodeID, atInput: SocketID) {
        neighbors.insert(
            Link(
                sourceNode: 0,
                sourceSocket: id!,
                destinationNode: to,
                destinationSocket: atInput
            )
        )
    }

    func disconnect(link: Link) {
        neighbors.remove(link)
    }

    init(defaultValue: T) {
        self.currentValue = defaultValue
        self.defaultValue = defaultValue
    }
}
