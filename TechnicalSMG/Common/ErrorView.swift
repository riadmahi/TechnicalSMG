//
//  ErrorView.swift
//  TechnicalSMG
//
//  Created by Riad on 04/06/2025.
//

import SwiftUI

struct ErrorView: View {
    let message: String
    let onRetry: () -> Void
    let showRetryButton: Bool = true

    var body: some View {
        VStack(spacing: 16) {
            Text("Oops! Something went wrong")
                .brSonomaFont(.medium, 22)
                .multilineTextAlignment(.center)

            Text(message)
                .brSonomaFont(.regular, 16)
                .foregroundColor(Color("SilverColor"))
                .multilineTextAlignment(.center)
            
            if showRetryButton {
                Button(action: onRetry){
                    Text("Retry")
                        .brSonomaFont(.medium, 16)
                        .foregroundColor(Color("OnButtonColor"))
                }
                .padding(.vertical, 14)
                .padding(.horizontal, 32)
                .background(Color("ButtonColor"))
                .clipShape(Capsule())
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(message: "We hit a snag. Give it another go.") {
            // Retry action
        }
    }
}
