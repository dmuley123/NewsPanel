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
        List(viewModel.authorArticles, id: \.objectID) { article in
            VStack(alignment: .leading) {
                Text(article.summary ?? "")
                    .lineLimit(2)
                Text("Approved by: \( (article.approvedBy as? [String])?.count ?? 0 ) users")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
    }
}
