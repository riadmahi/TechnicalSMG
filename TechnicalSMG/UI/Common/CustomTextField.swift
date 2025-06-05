//
//  CustomTextField.swift
//  TechnicalSMG
//
//  Created by Riad on 05/06/2025.
//

import SwiftUI

struct CustomTextField: View {
    let placeholder: String
    @Binding var text: String
    var isMultiline: Bool = false

    var body: some View {
        Group {
            if isMultiline {
                TextField(placeholder, text: $text, axis: .vertical)
                    .lineLimit(4...8)
            } else {
                TextField(placeholder, text: $text)
            }
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color("CardColor"))
                .stroke(Color("LineColor"), lineWidth: 1)
        )
    }
}
