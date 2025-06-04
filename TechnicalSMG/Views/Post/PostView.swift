//
//  PostView.swift
//  TechnicalSMG
//
//  Created by Riad on 03/06/2025.
//

import SwiftUI

struct PostView: View {
    let post: Post
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(post.title)
                .brSonomaFont(.medium, 16)
                .foregroundColor(.primary)
                .lineLimit(2)

            
            Text(post.body)
                .brSonomaFont(.regular, 14)
                .foregroundColor(.secondary)
                .lineSpacing(2.5) // Better accessibility when reading
                .lineLimit(5)
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        let samplePost = Post(
            userId: 1,
            id: 42,
            title: "Mon super titre de post",
            body: """
            Voici le contenu complet du post. 
            Il peut comporter plusieurs lignes, du texte qui se termine ici. 
            """
        )
        
        PostView(post: samplePost)
            .previewLayout(.sizeThatFits)
    }
}
