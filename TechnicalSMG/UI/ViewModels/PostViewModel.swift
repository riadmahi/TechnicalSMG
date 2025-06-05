//
//  PostViewModel.swift
//  TechnicalSMG
//
//  Created by Riad on 04/06/2025.
//

import Foundation

@MainActor
class PostViewModel: ObservableObject {
    @Published var isLoading: Bool = true
    @Published var posts: [Post] = []
    @Published var errorMessage: String? = nil
    
    private let repository: APIRepository
    
    init(repository: APIRepository) {
        self.repository = repository
    }
    
    func loadPosts() {
        self.errorMessage = nil
        self.isLoading = true
        repository.fetchPosts { [weak self] posts, error in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.isLoading = false
                if let error = error {
                    self.errorMessage = error.localizedDescription
                } else if let posts = posts {
                    self.posts = posts
                }
            }
        }
    }
}
