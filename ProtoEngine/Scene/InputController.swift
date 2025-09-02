//
//  InputController.swift
//  ProtoEngine
//
//  Created by Milton Montiel on 01/09/25.
//

import GameController

class InputController {
    struct Point {
        var x: Float
        var y: Float
        static let zero = Point(x: 0, y: 0)
    }

    static let shared = InputController()

    var keysPressed: Set<GCKeyCode> = []
    /// Tracks when the player does a left-click.
    var leftMouseDown = false
    /// Movement since the last tracked movement.
    var mouseDelta = Point.zero
    /// Fow much the player scroll with the mouse wheel.
    var mouseScroll = Point.zero

    private init() {
        let center = NotificationCenter.default
        center.addObserver(
            forName: .GCKeyboardDidConnect,
            object: nil,
            queue: nil
        ) {
            notification in

            let keyboard = notification.object as? GCKeyboard

            keyboard?.keyboardInput?.keyChangedHandler = {
                _,
                _,
                keyCode,
                pressed in

                if pressed {
                    self.keysPressed.insert(keyCode)
                } else {
                    self.keysPressed.remove(keyCode)
                }
            }
        }

        center.addObserver(forName: .GCMouseDidConnect, object: nil, queue: nil)
        {
            notification in
            let mouse = notification.object as? GCMouse

            mouse?.mouseInput?.leftButton.pressedChangedHandler = {
                _,
                _,
                pressed in
                self.leftMouseDown = pressed
            }
            mouse?.mouseInput?.mouseMovedHandler = { _, deltaX, deltaY in
                self.mouseDelta = Point(x: deltaX, y: deltaY)
            }
            mouse?.mouseInput?.scroll.valueChangedHandler = {
                _,
                deltaX,
                deltaY in
                self.mouseScroll = Point(x: deltaX, y: deltaY)
            }
        }
        // TODO: Avoid processing shortcuts!!
        #if os(macOS)
            NSEvent.addLocalMonitorForEvents(matching: [.keyUp, .keyDown]) {
                _ in nil
            }
        #endif
    }
}
