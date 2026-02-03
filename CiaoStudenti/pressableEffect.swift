//
//  pressableEffect.swift
//  CiaoStudenti
//
//  Created by Foundation 33 on 03/02/26.
//

import SwiftUI

// This allows you to use .pressableEffect() on any view
extension View {
    func pressableEffect() -> some View {
        self.buttonStyle(PressableButtonStyle())
    }
}

// The logic for the shrinking animation
struct PressableButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .opacity(configuration.isPressed ? 0.9 : 1.0)
            .animation(.spring(response: 0.3, dampingFraction: 0.6), value: configuration.isPressed)
    }
}
