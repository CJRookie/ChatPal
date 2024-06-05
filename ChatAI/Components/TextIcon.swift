//
//  TextIcon.swift
//  ChatAI
//
//  Created by CJ on 5/16/24.
//

import SwiftUI

struct TextIcon: View {
    @Binding var isAnimate: Bool
    let title: String
    let lineHeight: CGFloat
    
    var body: some View {
        Text(title)
            .fontWeight(.semibold)
            .foregroundStyle(Constant.ColorData.gradient)
            .overlay(alignment: .bottom) {
                BouncingLine(isAnimate: $isAnimate, lineHeight: lineHeight)
            }
    }
}

#Preview {
    TextIcon(isAnimate: .constant(true), title: "Hi", lineHeight: 2)
}
