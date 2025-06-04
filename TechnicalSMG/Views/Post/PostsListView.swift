//
//  PostsListView.swift
//  TechnicalSMG
//
//  Created by Riad on 03/06/2025.
//

import SwiftUI

import SwiftUI

struct PostsListView: View {
    @ObservedObject var viewModel: PostViewModel

    var body: some View {
        NavigationView {
            Group {
                if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                        .padding()
                } else if viewModel.posts.isEmpty {
                    ProgressView("Loading...")
                        .onAppear {
                            viewModel.loadPosts()
                        }
                } else {
                    List(viewModel.posts) { post in
                       PostView(post: post)
                    }
                    .listStyle(PlainListStyle())
                }
            }
            .navigationTitle("Posts")
            .background(Color("BackgroundColor"))
        }
    }
}

#Preview {
    let viewModel = PostViewModel(repository: APIRepositoryImpl())
    viewModel.posts = [
        Post(userId: 1, id: 1, title: "Title 1", body: "This is an example of a body"),
        Post(userId: 2, id: 2, title: "Another title", body: "This is another example of a body.")
    ]
    return PostsListView(viewModel: viewModel)
}
