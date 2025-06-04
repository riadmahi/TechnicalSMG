//
//  APIRepositoryImpl.swift
//  TechnicalSMG
//
//  Created by Riad on 03/06/2025.
//

import Foundation

class APIRepositoryImpl: APIRepository {
    
    func fetchPosts(completion: @escaping ([Post]?, Error?) -> Void) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
            completion(nil, NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"]))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            
            if let data = data {
                do {
                    let posts = try JSONDecoder().decode([Post].self, from: data)
                    completion(posts, nil)
                } catch {
                    completion(nil, error)
                }
            } else {
                completion(nil, NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data received"]))
            }
        }
        task.resume()
    }
}
