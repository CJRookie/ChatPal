//
//  ImageInput.swift
//  ChatAI
//
//  Created by CJ on 5/18/24.
//

import SwiftUI

struct ImageInput: View {
    var images: [UIImage]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack {
                ForEach(images.indices, id: \.self) { index in
                    RoundedImage(image: images[index], width: 80, height: 72, color: .white)
                }
            }
            .padding(.leading, 4)
            .scrollTargetLayout()
        }
        .frame(height: 88)
        .scrollTargetBehavior(.viewAligned)
    }
}

#Preview {
    ImageInput(images: [])
}
