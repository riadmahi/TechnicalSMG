//
//  APIRepository.swift
//  TechnicalSMG
//
//  Created by Riad on 03/06/2025.
//

protocol APIRepository {
    func fetchPosts(completion: @escaping ([Post]?, Error?) -> Void)
    func fetchComments(for postId: Int, completion: @escaping ([Comment]?, Error?) -> Void)
    func createPost(title: String, body: String, completion: @escaping (Post?, Error?) -> Void)
}
