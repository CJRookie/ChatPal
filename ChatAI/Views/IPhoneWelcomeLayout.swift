//
//  IPhoneWelcomeLayout.swift
//  ChatAI
//
//  Created by CJ on 5/17/24.
//

import SwiftUI

struct IPhoneWelcomeLayout: View {
    @Environment(\.verticalSizeClass) private var verticalSizeClass
    @Binding var currentPrompt: String
    let prompts: [String]
    let greeting: String
    let width: CGFloat
    let height: CGFloat
    
    var body: some View {
        ZStack {
            VStack {
                if verticalSizeClass == .regular {
                    ForEach(prompts.indices, id: \.self) { index in
                        if index % 2 == 0 {
                            HStack {
                                PromptBox(currentPrompt: $currentPrompt, text: prompts[index])
                                PromptBox(currentPrompt: $currentPrompt, text: prompts[index + 1])
                            }
                        }
                    }
                } else {
                    HStack {
                        ForEach(prompts, id: \.self) { prompt in
                            PromptBox(currentPrompt: $currentPrompt, text: prompt)
                        }
                    }
                }
            }
            .frame(maxWidth: height * 3, maxHeight: height / 3)
            SlidingText(text: greeting)
                .offset(y: -height / 3)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    }
}

#Preview {
    IPhoneWelcomeLayout(currentPrompt: .constant("ok"), prompts: ["Cool", "Hot"], greeting: "Hello! How are you today?", width: 400, height: 600)
}
