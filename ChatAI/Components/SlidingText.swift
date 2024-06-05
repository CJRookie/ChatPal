//
//  SlidingText.swift
//  ChatAI
//
//  Created by CJ on 5/14/24.
//

import SwiftUI

struct SlidingText: View {
    let text: String
    @State private var isActive: Bool = false
    
    var body: some View {
        Text(text)
            .font(.title)
            .fontWeight(.medium)
            .foregroundStyle(Constant.ColorData.gradient)
            .overlay {
                GeometryReader { proxy in
                    Rectangle()
                        .fill(.background)
                        .offset(x: isActive ? proxy.size.width : 0)
                }
            }
            .onAppear {
                withAnimation(.easeInOut(duration: 0.8)) {
                    isActive = true
                }
            }
    }
}

#Preview {
    SlidingText(text: "Hello")
}
