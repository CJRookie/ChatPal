//
//  InfiniteRotation.swift
//  ChatAI
//
//  Created by CJ on 5/12/24.
//

import SwiftUI

struct Avatar: View {
    let imageName: String
    
    var body: some View {
        Image(systemName: imageName)
            .imageScale(.large)
            .foregroundStyle(LinearGradient(colors: [.blue, .purple], startPoint: .topLeading, endPoint: .bottomTrailing))
    }
}

#Preview {
    Avatar(imageName: "diamond.circle.fill")
}
