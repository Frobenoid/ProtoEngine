//
//  Node.swift
//  ProtoEngine
//
//  Created by Milton Montiel on 01/11/25.
//

class Node {
    var inputs: [any Socket] = []
    var outputs: [any Socket] = []

    var label: String = ""
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

    func connect(atOutput: SocketID, to: NodeID, atInput: SocketID) {

    }
}

class MathNode: Node {
    override init() {
        super.init()
        addInput(InSocket<Int>(defaultValue: 100))
        addInput(InSocket<Int>(defaultValue: 100))
        addOutput(OutSocket(defaultValue: 0))
        label = "Math"
    }

    override func execute() {
        let a: Int = getInput(at: 0).currentValue
        let b: Int = getInput(at: 1).currentValue

        setOutput(
            at: 0,
            to: a + b
        )
    }
}

class ConstantNode: Node {
    override init() {
        super.init()
        addOutput(OutSocket(defaultValue: 100))
        label = "Constant"
    }
    
    override func execute() {
    }
}
