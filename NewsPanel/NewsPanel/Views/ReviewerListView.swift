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
            ForEach(viewModel.groupedReviewerArticles.keys.sorted(), id: \.self) { author in
                Section(header: Text(author)) {
                    ForEach(viewModel.groupedReviewerArticles[author] ?? [], id: \.id) { article in
                        VStack(alignment: .leading) {
                            HStack {
                                Button(action: {
                                    viewModel.toggleSelection(for: article.objectID)
                                }) {
                                    Image(systemName: viewModel.selectedArticles.contains(article.objectID) ? "checkmark.square" : "square")
                                }
                                .buttonStyle(.plain)
                                
                                Text(article.summary)
                                    .font(.headline)
                                    .lineLimit(2)
                            }
                            
                            Text("Details: \(article.fullContent)")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                                .lineLimit(4)
                        }
                        .onAppear {
                            if viewModel.isLast(articleID: article.id) {
                                viewModel.loadNextPage()
                            }
                        }
                    }
                }
            }
        }
        .listStyle(.insetGrouped)
    }
}
