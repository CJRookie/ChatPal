//
//  SubmitCancelButton.swift
//  ChatAI
//
//  Created by CJ on 5/14/24.
//

import SwiftUI

struct SubmitCancelButton: View {
    @Binding var isResponding: Bool
    let submit: () -> Void
    let cancel: () -> Void
    
    var body: some View {
        Button(action: isResponding ? cancel : submit) {
            Image(systemName: isResponding ? "stop.circle.fill" : "paperplane.circle.fill")
                .imageScale(.large)
        }
    }
}

#Preview {
    SubmitCancelButton(isResponding: .constant(false)) {
        
    } cancel: {
        
    }
}
