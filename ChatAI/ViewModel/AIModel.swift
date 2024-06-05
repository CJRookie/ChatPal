//
//  AIModel.swift
//  ChatAI
//
//  Created by CJ on 4/29/24.
//

import Foundation
import GoogleGenerativeAI
import _PhotosUI_SwiftUI

@Observable
class AIModel {
    private let model: GenerativeModel
    private(set) var chat: Chat
    private(set) var messages: [Message]
    var images: [UIImage] = []
    private let largestImageDimension = 400.0
    
    init(messages: [Message]) {
        model = GenerativeModel(name: "gemini-1.5-flash-latest", apiKey: APIKey.default)
        chat = model.startChat()
        self.messages = messages
    }
    
    func convertToImage(from items: [PhotosPickerItem]) async {
        images.removeAll()
        for item in items {
            if let data = try? await item.loadTransferable(type: Data.self), let image = UIImage(data: data) {
                if image.size.fit(largestDimension: largestImageDimension) {
                    images.append(image)
                } else {
                    let size = image.size.aspectFit(largestDimension: largestImageDimension)
                    if let resizedImage = image.preparingThumbnail(of: size) {
                        images.append(resizedImage)
                    }
                }
            }
        }
    }
    
    func send(_ message: String, _ items: [PhotosPickerItem]) async {
        var userMessage: Message
        var contentStream: AsyncThrowingStream<GenerateContentResponse, any Error>
        var copiedImages: [UIImage] = []
        if items.isEmpty {
            userMessage = Message(role: .user, text: message)
        } else {
            copiedImages = images
            images.removeAll()
            userMessage = Message(role: .user, text: message, images: copiedImages)
        }
        messages.append(userMessage)
        var modelMessage = Message(role: .model, text: "")
        modelMessage.isLoading = true
        messages.append(modelMessage)
        if items.isEmpty {
            contentStream = chat.sendMessageStream(message)
        } else {
            let imgs = copiedImages as [any ThrowingPartsRepresentable]
            contentStream = model.generateContentStream(message, imgs)
        }
        do {
            for try await chunk in contentStream {
                if let text = chunk.text {
                    messages[messages.count - 1].isLoading = false
                    messages[messages.count - 1].text += text
                }
            }
        } catch {
            messages.removeLast()
            let response = "Something is wrong: \(error.localizedDescription)"
            messages.append(Message(role: .model, text: response))
        }
    }
    
    func cancel() {
        messages[messages.count - 1].isLoading = false
        messages[messages.count - 1].text = "The request has been cancelled."
    }
    
    func startNewChat() {
        messages.removeAll()
        images.removeAll()
        chat = model.startChat()
    }
}

private extension CGSize {
  func fit(largestDimension length: CGFloat) -> Bool {
    return width <= length && height <= length
  }

  func aspectFit(largestDimension length: CGFloat) -> CGSize {
    let aspectRatio = width / height
    if width > height {
      let width = min(width, length)
      return CGSize(width: width, height: round(width / aspectRatio))
    } else {
      let height = min(height, length)
      return CGSize(width: round(height * aspectRatio), height: height)
    }
  }
}

