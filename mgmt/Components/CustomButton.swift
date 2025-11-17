//
//  CustomButton.swift
//  mgmt
//
//  Created by Ana Karina Aramoni Ruiz on 08/11/25.
//

import SwiftUI

struct CustomButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.title2.weight(.light))
            .frame(maxWidth: .infinity)
            .padding(.vertical, 18)

            .background(
                EllipticalGradient(
                    gradient: Gradient(colors: [
                        Color(red: 81 / 255, green: 100 / 255, blue: 255 / 255),
                        Color(red: 169 / 255, green: 164 / 255, blue: 246 / 255)
                    ]),
                    center: .center,
                )
            )
            .clipShape(RoundedRectangle(cornerRadius: 30))
            .shadow(color: Color(red: 0.4, green: 0.45, blue: 0.95).opacity(0.3),
                    radius: 20, x: 0, y: 10)
            .foregroundStyle(Color(.white))
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

