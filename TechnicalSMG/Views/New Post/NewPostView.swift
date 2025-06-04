//
//  NewPostView.swift
//  TechnicalSMG
//
//  Created by Riad on 04/06/2025.
//

import SwiftUI

struct NewPostView: View {
    @StateObject private var viewModel: NewPostViewModel
    @Environment(\.dismiss) private var dismiss
    
    init(repository: APIRepository) {
        _viewModel = StateObject(wrappedValue: NewPostViewModel(repository: repository))
    }

    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 32) {
                Text("Create a new post")
                    .brSonomaFont(.medium, 24)
                    .fontWeight(.bold)
                    .padding(.horizontal, 20)
                    .padding(.top, 32)
                
                TextField("Title", text: $viewModel.title)
                    .padding(16)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color("ContainerColor"))
                            .stroke(Color("LineColor"), lineWidth: 1)
                    )
                    .padding(.horizontal, 20)
                
                TextField("Describe your post here...", text: $viewModel.description, axis: .vertical)
                    .lineLimit(4...8)
                    .padding(16)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color("ContainerColor"))
                            .stroke(Color("LineColor"), lineWidth: 1)
                    )
                    .padding(.horizontal, 20)
                
                Button(action: {
                    viewModel.createPost {
                        dismiss()
                    }
                }) {
                    if viewModel.isPosting {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            .frame(maxWidth: .infinity)
                    } else {
                        Text("Create")
                            .brSonomaFont(.medium, 16)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                    }
                }
                .padding(.vertical, 20)
                .padding(.horizontal, 32)
                .background(Color("ButtonColor"))
                .clipShape(Capsule())
                .padding(.horizontal, 20)
                .disabled(viewModel.isPosting)
                
                Spacer()
            }
            .background(Color("BackgroundColor"))
            .ignoresSafeArea(edges: .bottom)
            
            if viewModel.showToast {
                VStack {
                    Spacer()
                    ToastView(message: viewModel.toastMessage, style: viewModel.toastStyle)
                        .padding(.bottom, 32)
                }
                .transition(.move(edge: .bottom).combined(with: .opacity))
                .animation(.easeInOut, value: viewModel.showToast)
            }
        }
    }
}
