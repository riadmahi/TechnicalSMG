//
//  Post.swift
//  TechnicalSMG
//
//  Created by Riad on 03/06/2025.
//

struct Post: Identifiable, Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}
