//
//  MessageLog.swift
//  ChatAI
//
//  Created by CJ on 5/22/24.
//

import Foundation

struct MessageLog: Identifiable {
    let id: UUID
    let topic: String
    let message: [Message]
    let timeStamp: Date = Date.now
    
    init(id: UUID = UUID(), topic: String, message: [Message]) {
        self.id = id
        self.topic = topic
        self.message = message
    }
}
