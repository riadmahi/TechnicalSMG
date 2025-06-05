//
//  PostDetailsView.swift
//  TechnicalSMG
//
//  Created by Riad on 04/06/2025.
//

import SwiftUI

struct PostDetailsView: View {
    @StateObject private var viewModel: PostDetailsViewModel
    @State private var imageReloadToken = UUID()

    init(post: Post, repository: APIRepository) {
        _viewModel = StateObject(wrappedValue: PostDetailsViewModel(post: post, repository: repository))
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                imageHeader

                VStack(alignment: .leading, spacing: 16) {
                    Text(viewModel.post.title)
                        .brSonomaFont(.medium, 20)
                        .foregroundColor(.primary)

                    Text(viewModel.post.body)
                        .brSonomaFont(.regular, 18)
                        .lineSpacing(4)

                    commentsSection
                }
                .padding(.horizontal, 24)
                .padding(.top, 24)
            }
        }
        .ignoresSafeArea(edges: .top)
        .navigationTitle("Post Details")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.loadComments()
        }
    }

    private var imageHeader: some View {
        ZStack {
            Color.gray.opacity(0.2)

            AsyncImage(url: URL(string: "https://picsum.photos/1200/800?\(imageReloadToken)")) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .transition(.opacity)
                case .success(let image):
                    image
                        .resizable()
                        .transition(.opacity)
                case .failure:
                    VStack(spacing: 6) {
                        Image(systemName: "arrow.clockwise.circle")
                            .font(.system(size: 40))
                            .foregroundColor(.gray)
                        Text("Tap to retry")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    .onTapGesture {
                        imageReloadToken = UUID() // Dummy value to regenerate a new photo URL
                    }
                    .transition(.opacity)
                @unknown default:
                    EmptyView()
                }
            }
        }
        .frame(height: 300)
        .clipped()
    }


    private var commentsSection: some View {
        Group {
            if let error = viewModel.errorMessage {
                ErrorView(message: error, onRetry: {
                    viewModel.loadComments()
                })
            } else if viewModel.isLoading {
                loadingState
            } else if viewModel.comments.isEmpty {
                emptyState
            } else {
                commentsList
            }
        }
    }

    private var loadingState: some View {
        HStack {
            Spacer()
            ProgressView("Loading...")
            Spacer()
        }
    }

    private var emptyState: some View {
        VStack {
            Spacer()
            Text("There are no comments.")
                .brSonomaFont(.medium, 22)
                .multilineTextAlignment(.center)
            Spacer()
        }
    }

    private var commentsList: some View {
        VStack(spacing: 12) {
            commentHeader

            ForEach(viewModel.comments) { comment in
                commentItem(comment)
            }
        }
        .padding(.top, 8)
    }

    private var commentHeader: some View {
        HStack(spacing: 12) {
            Image("CommentIcon")
                .resizable()
                .frame(width: 32, height: 32)
                .foregroundColor(Color("SilverColor"))

            Text("\(viewModel.comments.count) Comments")
                .brSonomaFont(.medium, 16)
                .foregroundColor(Color("SilverColor"))

            Spacer()
        }
        .padding(.horizontal, 0)
    }

    private func commentItem(_ comment: Comment) -> some View {
        HStack {
            VStack(alignment: .leading, spacing: 6) {
                Text(comment.email)
                    .brSonomaFont(.medium, 12)
                    .foregroundColor(.accentColor)
                Text(comment.name)
                    .brSonomaFont(.medium, 14)
                Text(comment.body)
                    .brSonomaFont(.regular, 13)
            }
            Spacer()
        }
        .padding()
        .background(Color.gray.opacity(0.05))
        .cornerRadius(8)
        .padding(.horizontal, 0)
    }
}
