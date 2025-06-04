//
//  TechnicalSMGApp.swift
//  TechnicalSMG
//
//  Created by Riad on 03/06/2025.
//

import SwiftUI

@main
struct TechnicalSMGApp: App {
    let repository = APIRepositoryImpl()

    var body: some Scene {
        WindowGroup {
            NavigationView {
                PostsListView(repository: repository)
            }
        }
    }
}
