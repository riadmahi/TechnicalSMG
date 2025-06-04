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
            VStack {
                Image("BrandIcon")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 20)
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
                            NavigationLink(destination: PostDetailsView(post: post, repository: repository)) {
                                PostView(post: post)
                            }
                        }
                        .listStyle(PlainListStyle())
                    }
                }
            }
            
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
        .background(Color("BackgroundColor"))
    }
}

#Preview {
    return PostsListView(repository: APIRepositoryImpl())
}
