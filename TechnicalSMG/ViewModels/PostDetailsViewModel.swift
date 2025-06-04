//
//  PostDetailsViewModel.swift
//  TechnicalSMG
//
//  Created by Riad on 04/06/2025.
//


import Foundation

@MainActor
class PostDetailsViewModel: ObservableObject {
    
    let post: Post
    
    @Published var comments: [Comment] = []
    
    @Published var errorMessage: String? = nil
        
    private let repository: APIRepository
        
    init(post: Post, repository: APIRepository) {
        self.post = post
        self.repository = repository
    }
    
    func loadComments() {
        repository.fetchComments(for: post.id) { [weak self] fetchedComments, error in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                if let error = error {
                    self.errorMessage = error.localizedDescription
                } else if let fetched = fetchedComments {
                    // Keep only the first three comments
                    self.comments = Array(fetched.prefix(3))
                }
            }
        }
    }
}
