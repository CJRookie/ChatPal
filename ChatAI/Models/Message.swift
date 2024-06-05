//
//  Message.swift
//  ChatAI
//
//  Created by CJ on 5/7/24.
//

import Foundation
import UIKit

struct Message: Identifiable, Hashable {
    let id: UUID = UUID()
    var role: ChatRole
    var text: String
    var images: [UIImage]
    var isLoading: Bool = false
    let timestamp: Date = Date()
    
    init(role: ChatRole, text: String, images: [UIImage] = []) {
        self.role = role
        self.text = text
        self.images = images
    }
}

enum ChatRole {
    case user
    case model
}
