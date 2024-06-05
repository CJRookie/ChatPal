//
//  ImageButton.swift
//  ChatAI
//
//  Created by CJ on 5/26/24.
//

import SwiftUI
import PhotosUI

struct ImageButton: View {
    @Binding var selection: [PhotosPickerItem]
    
    var body: some View {
        PhotosPicker(selection: $selection, matching: .images) {
            Image(systemName: "photo.circle.fill")
                .imageScale(.large)
        }
    }
}

#Preview {
    ImageButton(selection: .constant([]))
}
