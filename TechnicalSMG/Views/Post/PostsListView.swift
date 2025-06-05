//
//  PostsListView.swift
//  TechnicalSMG
//
//  Created by Riad on 03/06/2025.
//
import SwiftUI

struct PostsListView: View {
    @StateObject private var viewModel: PostViewModel
    private let repository: APIRepository

    init(repository: APIRepository) {
        self.repository = repository
        _viewModel = StateObject(wrappedValue: PostViewModel(repository: repository))
    }

    var body: some View {
        ZStack {
            content
            floatingAddButton
        }
        .background(Color("BackgroundColor"))
        .onAppear {
            viewModel.loadPosts()
        }
    }

    private var content: some View {
        VStack(spacing: 0) {
            header

            Group {
                if let error = viewModel.errorMessage {
                    ErrorView(message: error, onRetry: {
                        viewModel.loadPosts()
                    })
                } else if viewModel.isLoading {
                    loadingState
                } else if viewModel.posts.isEmpty {
                    emptyState
                } else {
                    postsList
                }
            }
        }
    }

    private var header: some View {
        Image("BrandIcon")
            .resizable()
            .scaledToFit()
            .frame(height: 20)
            .padding(.top, 16)
    }

    private var loadingState: some View {
        VStack {
            Spacer()
            ProgressView("Loading...")
            Spacer()
        }
    }

    private var emptyState: some View {
        VStack {
            Spacer()
            Text("There are no posts yet")
                .brSonomaFont(.medium, 22)
                .multilineTextAlignment(.center)
            Spacer()
        }
    }

    private var postsList: some View {
        List(viewModel.posts) { post in
            NavigationLink(destination: PostDetailsView(post: post, repository: repository)) {
                PostView(post: post)
            }
        }
        .listStyle(.plain)
    }

    private var floatingAddButton: some View {
        VStack {
            Spacer()
            NavigationLink(destination: NewPostView(repository: repository)) {
                Label {
                    Text("Add new post")
                        .brSonomaFont(.medium, 16)
                } icon: {
                    Image(systemName: "plus")
                        .font(.system(size: 16, weight: .medium))
                }
                .foregroundColor(Color("OnButtonColor"))
                .padding(.vertical, 20)
                .padding(.horizontal, 32)
                .background(Color("ButtonColor"))
                .clipShape(Capsule())
            }
            .padding(.bottom, 20)
        }
    }
}

#Preview {
    PostsListView(repository: APIRepositoryImpl())
}
