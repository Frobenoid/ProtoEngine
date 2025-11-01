//
//  Node.swift
//  ProtoEngine
//
//  Created by Milton Montiel on 01/11/25.
//

class Node: Identifiable {
    var inputs: [any Socket] = []
    var outputs: [any Socket] = []
    
    var id: NodeID?
    
    func getUntypedInput(at index: SocketID) -> any Socket {
        return inputs[Int(index)]
    }
    
    func getUntypedOutput(at index: SocketID) -> any Socket {
        return outputs[Int(index)]
    }
    
    func getInput<T>(at index: SocketID) -> InSocket<T> {
        return inputs[Int(index)] as! InSocket<T>
    }
    
    func getOutput<T>(at index: SocketID) -> OutSocket<T> {
        return outputs[Int(index)] as! OutSocket<T>
    }
    
    func addInput(_ socket: any Socket) {
        inputs.append(socket)
    }
    
    func addOutput(_ socket: any Socket) {
        outputs.append(socket)
    }
    
    func setOutput(at index: SocketID, to value: Any) {
        outputs[Int(index)].setCurrentValue(to: value)
    }
    
    func execute() {}
    
//    nodes[from].connect(atOutput: atOutput, to: to, atInput: atInput)
    func connect(atOutput: SocketID, to:NodeID, atInput: SocketID) {
        
    }
}

class MathNode: Node {
    override init() {
        super.init()
        addInput(InSocket<Int>(defaultValue: 100))
        addInput(InSocket<Int>(defaultValue: 100))
        addOutput(OutSocket(defaultValue: 0))
    }
    
    override func execute() {
        var a : Int = getInput(at: 0).currentValue
        var b : Int = getInput(at: 1).currentValue
        
        setOutput(at: 0, to: a + b)
    }
}
