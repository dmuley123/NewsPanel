//
//  AuthorListView.swift
//  NewsPanel
//
//  Created by Dnyaneshwar Muley on 10/07/25.
//

import Foundation
import SwiftUI

struct AuthorListView: View {
    @ObservedObject var viewModel: NewsListViewModel

    var body: some View {
        List(viewModel.authorArticles, id: \.id) { article in
            VStack(alignment: .leading, spacing: 6) {
                Text(article.summary)
                    .font(.headline)
                    .lineLimit(2)

                Text("Content: \(article.fullContent)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(4)

                Text("Approved by: \(article.approveCount) users")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .padding(.vertical, 4)
        }
    }
}
