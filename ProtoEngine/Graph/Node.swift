//
//  Node.swift
//  ProtoEngine
//
//  Created by Milton Montiel on 01/11/25.
//
import CoreGraphics

class Node {
    var inputs: [any Socket] = []
    var outputs: [any Socket] = []

    var label: String = ""
    var id: NodeID?

    var isSelected = false
    var isDragging = true
    var offset: CGSize = .zero

    func getUntypedInput(at index: SocketID) -> any Socket {
        return inputs[Int(index)]
    }

    func setUntypedInput(at index: SocketID, to: Any) {
        inputs[index].setUntypedCurrentValue(to: to)
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
        inputs[inputs.count - 1].id = inputs.count - 1
    }

    func addOutput(_ socket: any Socket) {
        outputs.append(socket)
        outputs[outputs.count - 1].id = SocketID(outputs.count - 1)
    }

    func setOutput(at index: SocketID, to value: Any) {
        outputs[Int(index)].setUntypedCurrentValue(to: value)
    }

    func getNeighbors() -> Set<Link> {
        var n = Set<Link>()
        for output in outputs {
            for i in output.getNeighbors() {
                n.insert(i)
            }
        }
        return n
    }

    func execute() {}

    func connect(atOutput: SocketID, to: NodeID, atInput: SocketID) {
        outputs[atOutput].connect(to: to, atInput: atInput)
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
