//
//  WelcomeView.swift
//  ChatAI
//
//  Created by CJ on 5/17/24.
//

import SwiftUI

struct WelcomeView: View {
    @Binding var currentPrompt: String
    var prompts = ["Generate a short story", "Quiz me a brain teaser", "How to make a salad", "Tell me a joke"]
    let greeting: String
    
    var body: some View {
        GeometryReader { proxy in
            let height = proxy.size.height
            let width = proxy.size.width
            if UIDevice.isIPhone {
                IPhoneWelcomeLayout(currentPrompt: $currentPrompt, prompts: prompts, greeting: greeting, width: width, height: height)
            } else if UIDevice.isIPad {
                IPadWelcomeLayout(currentPrompt: $currentPrompt, prompts: prompts, greeting: greeting, width: width, height: height)
            }
        }
    }
}

#Preview {
    WelcomeView(currentPrompt: .constant("ok"), greeting: "Hello! How are you today?")
}
