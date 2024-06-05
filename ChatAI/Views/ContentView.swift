//
//  ContentView.swift
//  ChatAI
//
//  Created by CJ on 4/28/24.
//

import SwiftUI
import Lottie
import GoogleGenerativeAI

struct ContentView: View {
    @Environment(\.verticalSizeClass) private var verticalSizeClass
    @State private var selectedMsgLog: UUID = UUID()
    @State private var vm: AIModel
    
    init(messages: [Message] = []) {
        _vm = State(initialValue: AIModel(messages: messages))
    }
    
    var body: some View {
        if UIDevice.isIPhone && (!UIDevice.isProMax || verticalSizeClass == .regular) {
            NavigationStack {
                MainView(vm: vm)
            }
        } else {
            NavigationSplitView {
                ChatLog(messageLogs: [], selectedMsgLog: $selectedMsgLog)
            } detail: {
                MainView(vm: vm)
            }
        }
    }
}

extension UIDevice {
    static var isIPad: Bool {
        UIDevice.current.userInterfaceIdiom == .pad
    }
    
    static var isIPhone: Bool {
        UIDevice.current.userInterfaceIdiom == .phone
    }
    
    static var isMac: Bool {
        UIDevice.current.userInterfaceIdiom == .mac
    }
    
    static var isProMax: Bool {
        UIDevice().name.contains("Pro Max")
    }
}

#Preview {
    ContentView()
}
