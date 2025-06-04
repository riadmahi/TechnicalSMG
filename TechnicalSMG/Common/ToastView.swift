//
//  ToastView.swift
//  TechnicalSMG
//
//  Created by Riad on 04/06/2025.
//


import SwiftUI

struct ToastView: View {
    let message: String
    let style: ToastStyle
    
    var backgroundColor: Color {
        switch style {
        case .success: return Color.green
        case .error: return Color.red
        }
    }
    
    var body: some View {
        Text(message)
            .brSonomaFont(.medium, 14)
            .foregroundColor(.white)
            .padding(.horizontal, 20)
            .padding(.vertical, 12)
            .background(backgroundColor)
            .cornerRadius(20)
            .shadow(radius: 5)
    }
}
