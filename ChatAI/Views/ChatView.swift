//
//  ChatView.swift
//  ChatAI
//
//  Created by CJ on 5/12/24.
//

import SwiftUI

struct ChatView: View {
    let messages: [Message]
    @Binding var isResponding: Bool
    
    var body: some View {
        VStack {
            ForEach(messages) { message in
                HStack(alignment: .top) {
                    if message.role == .user {
                        Avatar(imageName: "person.crop.circle.fill")
                    } else {
                        if message.id == messages.last?.id {
                            Avatar(imageName: "diamond.circle.fill")
                                .rotationEffect(.degrees(isResponding ? 360 : 0))
                                .animation(isResponding ? .linear(duration: 2).repeatForever(autoreverses: false) : .linear(duration: 0), value: isResponding)
                        } else {
                            Avatar(imageName: "diamond.circle.fill")
                        }
                    }
                    BubbleMessage(message: message)
                    Spacer()
                }
            }
            .padding(.vertical, 4)
        }
    }
}

#Preview {
    ChatView(messages: [Message(role: .user, text: "Hi")], isResponding: .constant(false))
}
