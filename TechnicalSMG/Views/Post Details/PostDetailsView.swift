//
//  PostDetailsView.swift
//  TechnicalSMG
//
//  Created by Riad on 04/06/2025.
//

import SwiftUI

struct PostDetailsView: View {    
    @StateObject private var viewModel: PostDetailsViewModel
    
    init(post: Post, repository: APIRepository) {
        _viewModel = StateObject(wrappedValue: PostDetailsViewModel(post: post, repository: repository))
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                AsyncImage(url: URL(string: "https://picsum.photos/seed/600/300")) { phase in
                    switch phase {
                    case .empty:
                        ZStack {
                            Color.gray.opacity(0.2)
                            ProgressView()
                        }
                        .frame(height: 200)
                        .cornerRadius(12)
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(height: 200)
                            .clipped()
                            .cornerRadius(12)
                    case .failure:
                        ZStack {
                            Color.gray.opacity(0.2)
                            Image(systemName: "photo")
                                .font(.largeTitle)
                                .foregroundColor(.gray)
                        }
                        .frame(height: 200)
                        .cornerRadius(12)
                    @unknown default:
                        EmptyView()
                    }
                }
                .padding(.bottom, 8)

                Text(viewModel.post.title)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)

                Text(viewModel.post.body)
                    .font(.body)
                    .foregroundColor(.primary)
                    .lineSpacing(4)

                Divider()

                if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .padding(.vertical, 8)
                } else if viewModel.comments.isEmpty {
                    ProgressView("Loading...")
                        .padding(.vertical, 8)
                } else {
                    ForEach(viewModel.comments) { comment in
                        VStack(alignment: .leading, spacing: 6) {
                            Text(comment.name)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text(comment.body)
                                .font(.body)
                                .foregroundColor(.secondary)
                            Text("\(comment.email)")
                                .font(.footnote)
                                .foregroundColor(.gray)
                        }
                        .padding()
                        .background(Color.gray.opacity(0.05))
                        .cornerRadius(8)
                        .padding(.bottom, 4)
                    }
                }

                Spacer()
            }
            .padding()
        }
        .navigationTitle("Post Details")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.loadComments()
        }
        .padding()
    }
}
