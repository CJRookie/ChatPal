//
//  BubbleMessage.swift
//  ChatAI
//
//  Created by CJ on 5/7/24.
//

import SwiftUI
import GoogleGenerativeAI

struct BubbleMessage: View {
    let message: Message
    
    var body: some View {
        if message.role == .model && message.isLoading {
            LoadingAnimation(lottieFile: "PaperplaneLoading")
        } else {
            VStack(alignment: .leading) {
                if message.role == .user && message.images.count > 0 {
                    ImageInput(images: message.images)
                }
                Text(message.text)
            }
            .padding(4)
            .animation(.linear, value: message.text)
            .foregroundStyle(message.role == .user ? .white : .primary)
            .background(message.role == .user ? .blue : .primaryBG.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

#Preview {
    BubbleMessage(message: .init(role: .model, text: "Hello"))
}
