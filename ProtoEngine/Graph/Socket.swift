//
//  Socket.swift
//  ProtoEngine
//
//  Created by Milton Montiel on 01/11/25.
//

typealias SocketID = UInt16
typealias NodeID = UInt16

struct Link: Hashable {
    let sourceSocket: SocketID
    let destinationNode: NodeID
    let destinationSocket: SocketID
}

protocol Socket {
    var id: SocketID? { get set }

    // Untyped value modifiers.
    mutating func setCurrentValue(to value: Any)
    mutating func untypedCurrentValue() -> Any

    func getNeighbors() -> Set<Link>
    func connect(to: NodeID, atInput: SocketID)
}

class InSocket<T>: Socket {
    var currentValue: T
    var defaultValue: T
    
    var id: SocketID?
    
    func setCurrentValue(to value: Any) {
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

}

class OutSocket<T>: Socket {
    var currentValue: T
    var defaultValue: T
    
    var id: SocketID?
    
    var neighbors: Set<Link> = []
    
    func setCurrentValue(to value: Any) {
        self.currentValue = value as! T
    }
    
    func untypedCurrentValue() -> Any {
        return currentValue as Any
    }
    
    func getNeighbors() -> Set<Link> {
        return []
    }
    
    func connect(to: NodeID, atInput: SocketID) {
        neighbors.insert(Link(sourceSocket: id!, destinationNode: to, destinationSocket: atInput))
    }
    
    init(defaultValue: T) {
        self.currentValue = defaultValue
        self.defaultValue = defaultValue
    }
}
