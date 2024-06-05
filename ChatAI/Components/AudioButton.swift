//
//  AudioButton.swift
//  ChatAI
//
//  Created by CJ on 5/30/24.
//

import SwiftUI
import Speech
import AVFoundation

struct AudioButton: View {
    var body: some View {
        Button {
            
        } label: {
            Image(systemName: "headphones.circle.fill")
        }
    }
    
    private var speechRecognizer = SFSpeechRecognizer(locale: .current)
    private func requestAuth() {
        SFSpeechRecognizer.requestAuthorization { authStatus in
            OperationQueue.main.addOperation {
                if authStatus == .authorized {
                    
                } else {
                    
                }
            }
        }
    }
}

#Preview {
    AudioButton()
}
