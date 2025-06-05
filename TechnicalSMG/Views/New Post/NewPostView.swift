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
    @FocusState private var focusedField: Field?

    init(repository: APIRepository) {
        _viewModel = StateObject(wrappedValue: NewPostViewModel(repository: repository))
    }

    var body: some View {
        ZStack {
            content
            toastOverlay
        }
        .ignoresSafeArea(edges: .bottom)
    }

    private var content: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 32) {
                titleHeader
                titleField
                descriptionField
                submitButton
                Spacer(minLength: 100)
            }
            .padding(.horizontal, 20)
            .padding(.top, 32)
        }
        .onTapGesture {
            hideKeyboard()
        }
    }

    private var titleHeader: some View {
        Text("Create a new post")
            .brSonomaFont(.medium, 24)
    }

    private var titleField: some View {
        CustomTextField(
            placeholder: "Title",
            text: $viewModel.title,
            isMultiline: false
        )
        .focused($focusedField, equals: .title)
        .submitLabel(.next)
        .onSubmit { focusedField = .description }
    }

    private var descriptionField: some View {
        CustomTextField(
            placeholder: "Describe your post here...",
            text: $viewModel.description,
            isMultiline: true
        )
        .focused($focusedField, equals: .description)
    }

    private var submitButton: some View {
        Button(action: {
            hideKeyboard()
            viewModel.createPost { dismiss() }
        }) {
            if viewModel.isPosting {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .frame(maxWidth: .infinity)
            } else {
                Text("Create")
                    .brSonomaFont(.medium, 16)
                    .frame(maxWidth: .infinity)
            }
        }
        .padding(.vertical, 20)
        .padding(.horizontal, 32)
        .foregroundColor(Color("OnButtonColor"))
        .background(Color("ButtonColor"))
        .clipShape(Capsule())
        .disabled(viewModel.isPosting)
    }

    private var toastOverlay: some View {
        Group {
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

    private func hideKeyboard() {
        UIApplication.shared.sendAction(
            #selector(UIResponder.resignFirstResponder),
            to: nil,
            from: nil,
            for: nil
        )
    }
    
    private enum Field: Hashable {
        case title, description
    }
}
