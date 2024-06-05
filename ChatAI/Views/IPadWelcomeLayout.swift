//
//  IPadWelcomeLayout.swift
//  ChatAI
//
//  Created by CJ on 5/17/24.
//

import SwiftUI

struct IPadWelcomeLayout: View {
    @Binding var currentPrompt: String
    let prompts: [String]
    let greeting: String
    let width: CGFloat
    let height: CGFloat
    
    var body: some View {
        ZStack {
            HStack {
                ForEach(prompts, id: \.self) { prompt in
                    PromptBox(currentPrompt: $currentPrompt, text: prompt)
                }
            }
            .frame(maxWidth: width / 1.2, maxHeight: width / 8)
            SlidingText(text: greeting)
                .offset(y: -(height / 4 + width / 16))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    }
}

#Preview {
    IPadWelcomeLayout(currentPrompt: .constant("ok"), prompts:["prompt1", "prompt2"], greeting: "Hello! How are you today?", width: 400, height: 600)
}
