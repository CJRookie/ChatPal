//
//  ChatLog.swift
//  ChatAI
//
//  Created by CJ on 5/22/24.
//

import SwiftUI
import SwiftData

struct ChatLog: View {
    var messageLogs: [MessageLog] = []
    @Binding var selectedMsgLog: UUID
    
    var body: some View {
        List(messageLogs) { log in
            Text(log.topic)
                .listRowBackground(RoundedRectangle(cornerRadius: 24).fill(selectedMsgLog == log.id ? .primaryBG.opacity(0.2) : .clear))
                .listRowSeparator(.hidden)
                .onTapGesture {
                    selectedMsgLog = log.id
                }
        }
        .listStyle(.plain)
    }
}

extension ChatLog {
    static let sampleData: [MessageLog] = [MessageLog(id: UUID(uuidString: "abc") ?? UUID(), topic: "1", message: []), MessageLog(id: UUID(uuidString: "cba") ?? UUID(), topic: "2", message: [])]
}

#Preview {
    ChatLog(messageLogs: ChatLog.sampleData, selectedMsgLog: .constant(ChatLog.sampleData.first?.id ?? UUID()))
}
