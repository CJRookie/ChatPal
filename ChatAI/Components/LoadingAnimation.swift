//
//  LoadingAnimation.swift
//  ChatAI
//
//  Created by CJ on 5/13/24.
//

import SwiftUI
import Lottie

struct LoadingAnimation: View {
    let lottieFile: String
    
    var body: some View {
        LottieView(animation: .named(lottieFile))
            .playbackMode(.playing(.toProgress(1, loopMode: .loop)))
            .scaledToFit()
            .frame(width: 75, height: 35)
    }
}

#Preview {
    LoadingAnimation(lottieFile: "PaperplaneLoading")
}
