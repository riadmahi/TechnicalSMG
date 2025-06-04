//
//  NewPostViewModel.swift
//  TechnicalSMG
//
//  Created by Riad on 04/06/2025.
//

import Foundation
import SwiftUI

@MainActor
class NewPostViewModel: ObservableObject {
    @Published var title: String = ""
    @Published var description: String = ""

    @Published var showToast: Bool = false
    @Published var toastMessage: String = ""
    @Published var toastStyle: ToastStyle = .success
    
    @Published var isPosting: Bool = false
    
    private let repository: APIRepository
    
    init(repository: APIRepository) {
        self.repository = repository
    }
    
    func createPost(onSuccess: @escaping () -> Void) {
        guard !title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            showToast(message: "Title is required", style: .error)
            return
        }

        guard !description.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            showToast(message: "Description is required", style: .error)
            return
        }

        isPosting = true

        repository.createPost(title: title, body: description) { [weak self] post, error in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.isPosting = false
                if let error = error {
                    self.showToast(message: "Failed to create post: \(error.localizedDescription)", style: .error)
                } else {
                    self.showToast(message: "Post created successfully!", style: .success)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        onSuccess()
                        self.title = ""
                        self.description = ""
                    }
                }
            }
        }
    }

    private func showToast(message: String, style: ToastStyle) {
        toastMessage = message
        toastStyle = style
        showToast = true

        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            self.showToast = false
        }
    }
}

