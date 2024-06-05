//
//  BouncingLine.swift
//  ChatAI
//
//  Created by CJ on 5/14/24.
//

import SwiftUI

struct BouncingLine: View {
    @Binding var isAnimate: Bool
    let lineHeight: CGFloat
    
    var body: some View {
        Rectangle()
            .foregroundStyle(Constant.ColorData.gradient)
            .frame(height: lineHeight)
            .mask {
                GeometryReader { proxy in
                    let width = proxy.size.width
                    Rectangle()
                        .frame(width: isAnimate ? width : 0)
                        .opacity(isAnimate ? 1 : 0)
                        .offset(x: isAnimate ? width : 0)
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 4))
            .animation(isAnimate ? .easeInOut(duration: 2).repeatForever() : .easeInOut(duration: 0), value: isAnimate)
    }
}

#Preview {
    BouncingLine(isAnimate: .constant(false), lineHeight: 8)
}
