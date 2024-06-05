//
//  DeleteButton.swift
//  ChatAI
//
//  Created by CJ on 5/30/24.
//

import SwiftUI

struct DeleteButton: View {
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            ZStack {
                Image(systemName: "minus.circle.fill")
                    .foregroundStyle(.white)
                Image(systemName: "minus.circle")
                    .foregroundStyle(.red)
            }
            .frame(width: 16, height: 16)
        }
    }
}

#Preview {
    DeleteButton {}
}
