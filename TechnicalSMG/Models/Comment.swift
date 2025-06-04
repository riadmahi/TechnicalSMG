//
//  Comment.swift
//  TechnicalSMG
//
//  Created by Riad on 04/06/2025.
//

struct Comment: Identifiable, Decodable {
    let postId: Int
    let id: Int
    let name: String
    let email: String
    let body: String
}
