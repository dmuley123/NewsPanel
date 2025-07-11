//
//  NewsListView.swift
//  NewsPanel
//
//  Created by Dnyaneshwar Muley on 10/07/25.
//

import SwiftUI

struct NewsListView: View {
    @Environment(\.managedObjectContext) private var context
    @StateObject private var viewModel = NewsListViewModel()
    @State private var showAlert = false
    @State private var alertText = ""

    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isReviewer {
                    ReviewerListView(viewModel: viewModel)
                } else {
                    AuthorListView(viewModel: viewModel)
                }

                if viewModel.isReviewer {
                    Button("Mark Approve") {
                        viewModel.markSelectedArticlesApproved()
                        alertText = "Selected articles approved!"
                        showAlert = true
                    }
                    .padding()
                    .buttonStyle(.borderedProminent)
                }
            }
            .navigationTitle("News")
            .onAppear {
                viewModel.loadArticles(context: context)
            }
            .alert("Info", isPresented: $showAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(alertText)
            }
        }
    }
}

