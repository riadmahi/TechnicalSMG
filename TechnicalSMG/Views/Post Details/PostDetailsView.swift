//
//  PostDetailsView.swift
//  TechnicalSMG
//
//  Created by Riad on 04/06/2025.
//

import SwiftUI

struct PostDetailsView: View {
    let post: Post

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text(post.title)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)

                Text(post.body)
                    .font(.body)
                    .foregroundColor(.primary)
                    .lineSpacing(4)
            }
            .padding()
        }
        .navigationTitle("Post Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}
