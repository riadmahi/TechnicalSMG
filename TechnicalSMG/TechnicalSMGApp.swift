//
//  TechnicalSMGApp.swift
//  TechnicalSMG
//
//  Created by Riad on 03/06/2025.
//

import SwiftUI

@main
struct TechnicalSMGApp: App {
    @StateObject private var viewModel = PostViewModel(repository: APIRepositoryImpl())

    var body: some Scene {
        WindowGroup {
            PostsListView(viewModel: viewModel)
        }
    }
}
