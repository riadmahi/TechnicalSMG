//
//  APIRepository.swift
//  TechnicalSMG
//
//  Created by Riad on 03/06/2025.
//

protocol APIRepository {
    func fetchPosts(completion: @escaping ([Post]?, Error?) -> Void)
}
