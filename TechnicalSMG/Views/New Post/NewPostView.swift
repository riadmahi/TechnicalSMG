//
//  NewPostView.swift
//  TechnicalSMG
//
//  Created by Riad on 04/06/2025.
//

import SwiftUI

struct NewPostView: View {
    @State private var title: String = ""
    @State private var description: String = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 32) {
            Text("Create a new post")
                .brSonomaFont(.medium, 24)
                .fontWeight(.bold)
                .padding(.horizontal, 20)
                .padding(.top, 32)
            
            TextField("Title", text: $title)
                .padding(16)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color("ContainerColor"))
                        .stroke(Color("LineColor"), lineWidth: 1)
                )
                .padding(.horizontal, 20)
                .padding(.top, 24)
            
            
            ZStack(alignment: .topLeading) {
                TextField("Describe your post here...", text: $description, axis: .vertical)
                    .lineLimit(4...8)
                    .padding(16)
            }
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color("ContainerColor"))
                    .stroke(Color("LineColor"), lineWidth: 1)
            )
            .padding(.horizontal, 20)
            
            Button(action: {
            }) {
                Text("Create")
                    .brSonomaFont(.medium, 16)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
            }
            .foregroundColor(Color("OnButtonColor"))
            .padding(.vertical, 20)
            .padding(.horizontal, 32)
            .background(Color("ButtonColor"))
            .clipShape(Capsule())
            .padding(.horizontal, 20)
            
            Spacer()
        }
        .background(Color("BackgroundColor"))
        .ignoresSafeArea(edges: .bottom)
    }
}

#Preview {
    NewPostView()
}
