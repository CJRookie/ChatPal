//
//  PromptBox.swift
//  ChatAI
//
//  Created by CJ on 5/16/24.
//

import SwiftUI

struct PromptBox: View {
    @Environment(\.colorScheme) private var theme
    @State private var press: Bool = false
    @Binding var currentPrompt: String
    let text: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(.promptBoxBG)
                .opacity(theme == .light ? (press ? 0.1 : 0.05) : (press ? 0.6 : 0.4))
                .scaleEffect(press ? 0.97 : 1)
            Text(text)
                .lineLimit(3)
        }
        .animation(.easeInOut(duration: 0.3), value: press)
        .gesture(dragGesture)
    }
    
    private var dragGesture: some Gesture {
        DragGesture(minimumDistance: 0)
            .onChanged { _ in
                press = true
            }
            .onEnded { value in
                press = false
                if value.translation == .zero {
                    currentPrompt = text
                }
            }
    }
}

#Preview {
    PromptBox(currentPrompt: .constant("ok"), text: "Generate a story")
}
