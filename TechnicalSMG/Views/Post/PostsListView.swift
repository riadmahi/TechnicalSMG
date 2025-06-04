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
            ZStack {
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
                            NavigationLink(destination: PostDetailsView(post: post)) {
                                PostView(post: post)
                            }
                        }
                        .listStyle(PlainListStyle())
                    }
                }
                .navigationTitle("Posts")
                
                VStack {
                    Spacer()
                    NavigationLink(destination: NewPostView()) {
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
