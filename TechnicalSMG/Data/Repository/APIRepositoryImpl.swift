//
//  APIRepositoryImpl.swift
//  TechnicalSMG
//
//  Created by Riad on 03/06/2025.
//

import Foundation

class APIRepositoryImpl: APIRepository {

    private let baseURL = "https://jsonplaceholder.typicode.com"

    func fetchPosts(completion: @escaping ([Post]?, Error?) -> Void) {
        fetch(urlString: "\(baseURL)/posts", completion: completion)
    }

    func fetchComments(for postId: Int, completion: @escaping ([Comment]?, Error?) -> Void) {
        let urlString = "\(baseURL)/comments?postId=\(postId)"
        fetch(urlString: urlString, completion: completion)
    }

    func createPost(title: String, body: String, completion: @escaping (Post?, Error?) -> Void) {
        guard let url = URL(string: "\(baseURL)/posts") else {
            completion(nil, self.makeError("Invalid URL"))
            return
        }

        let postPayload = Post(userId: 1, id: 0, title: title, body: body)

        guard let httpBody = try? JSONEncoder().encode(postPayload) else {
            completion(nil, self.makeError("Failed to encode post"))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = httpBody
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                completion(nil, error)
                return
            }

            guard let data = data else {
                completion(nil, self.makeError("No data returned"))
                return
            }

            do {
                let post = try JSONDecoder().decode(Post.self, from: data)
                completion(post, nil)
            } catch {
                completion(nil, error)
            }
        }.resume()
    }

    
    //Generic function to simple fetch a data
    private func fetch<T: Decodable>(urlString: String, completion: @escaping (T?, Error?) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(nil, makeError("Invalid URL"))
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(nil, error)
                return
            }

            guard let data = data else {
                completion(nil, self.makeError("No data received"))
                return
            }

            do {
                let decoded = try JSONDecoder().decode(T.self, from: data)
                completion(decoded, nil)
            } catch {
                completion(nil, error)
            }
        }.resume()
    }

    private func makeError(_ message: String) -> NSError {
        NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: message])
    }
}
