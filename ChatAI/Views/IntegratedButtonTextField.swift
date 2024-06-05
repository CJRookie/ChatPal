//
//  IntegratedButtonTextField.swift
//  ChatAI
//
//  Created by CJ on 5/13/24.
//

import SwiftUI
import PhotosUI

struct IntegratedButtonTextField: View {
    @Binding var text: String
    @Binding var selection: [PhotosPickerItem]
    @Binding var isResponding: Bool
    @Bindable var vm: AIModel
    let submit: () -> Void
    let cancel: () -> Void
    @State private var imageDataTask: Task<Void, Never>?
    
    var body: some View {
        VStack {
            if vm.images.count > 0 {
                DeletableImageInput(images: $vm.images)
            }
            HStack(alignment: .bottom) {
                TextField("Enter a prompt", text: $text, axis: .vertical)
                    .onKeyPress(phases: .down) { press in
                        if press.key == .return {
                            if isResponding {
                                cancel()
                            } else if !(text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty) {
                                submit()
                            }
                            return .handled
                        } else {
                            return .ignored
                        }
                    }
                ImageButton(selection: $selection)
                if (!(text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty) || isResponding) {
                    SubmitCancelButton(isResponding: $isResponding, submit: submit, cancel: cancel)
                }
            }
        }
        .padding(4)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .stroke(lineWidth: 1)
                .fill(.primaryBG)
                .opacity(0.4)
        )
        .onChange(of: selection) {
            convertToImage()
        }
        .onDisappear {
            imageDataTask?.cancel()
        }
    }
    
    private func convertToImage() {
        imageDataTask?.cancel()
        imageDataTask = Task {
            await vm.convertToImage(from: selection)
        }
    }
}

#Preview {
    IntegratedButtonTextField(text: .constant("Ok"), selection: .constant([]), isResponding: .constant(false), vm: AIModel(messages: [])) {
        
    } cancel: {
        
    }
}
