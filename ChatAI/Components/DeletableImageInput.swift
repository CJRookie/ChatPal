//
//  DeletableImageInput.swift
//  ChatAI
//
//  Created by CJ on 5/30/24.
//

import SwiftUI

struct DeletableImageInput: View {
    @Binding var images: [UIImage]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack {
                ForEach(images.indices, id: \.self) { index in
                    ZStack(alignment: .topTrailing) {
                        RoundedImage(image: images[index], width: 72, height: 72, color: .primaryBG.opacity(0.5))
                        DeleteButton {
                            images.remove(at: index)
                        }
                    }
                }
            }
            .padding(.leading, 4)
            .scrollTargetLayout()
        }
        .frame(height: 80)
        .scrollTargetBehavior(.viewAligned)
    }
}

#Preview {
    DeletableImageInput(images: .constant([]))
}
