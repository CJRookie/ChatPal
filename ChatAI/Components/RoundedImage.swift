//
//  RoundedImage.swift
//  ChatAI
//
//  Created by CJ on 5/30/24.
//

import SwiftUI

struct RoundedImage: View {
    let image: UIImage
    let width: CGFloat
    let height: CGFloat
    let color: Color
    
    var body: some View {
        Image(uiImage: image)
            .resizable()
            .scaledToFill()
            .frame(width: width, height: height)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .overlay {
                RoundedRectangle(cornerRadius: 8).stroke(color, lineWidth: 4)
            }
    }
}

#Preview {
    RoundedImage(image: UIImage(systemName: "circle") ?? UIImage(), width: 72, height: 72, color: .white)
}
