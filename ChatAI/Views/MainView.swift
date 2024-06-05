//
//  MainView.swift
//  ChatAI
//
//  Created by CJ on 5/18/24.
//

import SwiftUI
import PhotosUI

struct MainView: View {
    @Environment(\.verticalSizeClass) private var verticalSizeClass
    @State private var text = ""
    @State private var selection: [PhotosPickerItem] = []
    @State private var sendMessage: Task<Void, Never>?
    @State private var isResponding = false
    @Bindable var vm: AIModel
    private var greeting = "Hello! How are you today?"
    private var title = "ChatPal"
    
    init(vm: AIModel) {
        self.vm = vm
    }
    
    var body: some View {
        VStack {
            if vm.messages.isEmpty {
                WelcomeView(currentPrompt: $text, greeting: greeting)
            } else {
                ScrollViewReader { proxy in
                    ScrollView {
                        ChatView(messages: vm.messages, isResponding: $isResponding)
                    }
                    .scrollIndicators(.hidden)
                    .onChange(of: vm.messages) { _, _ in
                        if vm.messages.count >= 2 {
                            let target = vm.messages[vm.messages.count - 2]
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                                withAnimation {
                                    proxy.scrollTo(target.id, anchor: .top)
                                }
                            }
                        }
                    }
                }
            }
            IntegratedButtonTextField(text: $text, selection: $selection, isResponding: $isResponding, vm: vm, submit: send, cancel: stop)
        }
        .padding()
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            toolbarItems
        }
        .onDisappear {
            sendMessage?.cancel()
        }
    }
    
    private var toolbarItems: some ToolbarContent {
        Group {
            ToolbarItem(placement: .principal) {
                TextIcon(isAnimate: $isResponding, title: title, lineHeight: 2)
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    initNewChat()
                } label: {
                    Image(systemName: "plus.bubble")
                        .imageScale(.large)
                }
            }
            if UIDevice.isIPhone && (!UIDevice.isProMax || verticalSizeClass == .regular) {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        
                    } label: {
                        Image(systemName: "list.bullet")
                    }
                }
            }
        }
    }
    
    private func initNewChat() {
        vm.startNewChat()
        text = ""
        selection.removeAll()
        reset()
    }
    
    private func send() {
        sendMessage?.cancel()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
            isResponding = true
        }
        sendMessage = Task {
            let input = text
            text = ""
            await vm.send(input, selection)
            selection.removeAll()
            isResponding = false
        }
    }
    
    private func stop() {
        reset()
        vm.cancel()
    }
    
    private func reset() {
        sendMessage?.cancel()
        sendMessage = nil
        isResponding = false
    }
}

#Preview {
    NavigationStack {
        MainView(vm: AIModel(messages: [Message(role: .model, text: "answer")]))
    }
}
