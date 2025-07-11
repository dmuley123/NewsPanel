//
//  ReviewerListView.swift
//  NewsPanel
//
//  Created by Dnyaneshwar Muley on 10/07/25.
//

import Foundation
import SwiftUI

struct ReviewerListView: View {
    @ObservedObject var viewModel: NewsListViewModel

    var body: some View {
        List {
            ForEach(viewModel.groupedArticles.keys.sorted(), id: \.self) { author in
                Section(header: Text(author)) {
                    ForEach(viewModel.groupedArticles[author] ?? [], id: \.objectID) { article in
                        HStack {
                            Button(action: {
                                viewModel.toggleSelection(for: article.objectID)
                            }) {
                                Image(systemName: viewModel.selectedArticles.contains(article.objectID) ? "checkmark.square" : "square")
                            }
                            .buttonStyle(.plain)

                            VStack(alignment: .leading) {
                                Text(article.summary ?? "")
                                    .lineLimit(2)
                            }
                        }
                    }
                }
            }
        }
        .listStyle(.insetGrouped)
    }
}
