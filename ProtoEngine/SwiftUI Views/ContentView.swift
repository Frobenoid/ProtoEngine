//
//  ContentView.swift
//  ProtoEngine
//
//  Created by Milton Montiel on 29/08/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            ProtoMetalView()
        }
        .border(Color.red)
        .padding()
    }
}

#Preview {
    ContentView()
}
