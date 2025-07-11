//
//  NewsListViewModel.swift
//  NewsPanel
//
//  Created by Dnyaneshwar Muley on 10/07/25.
//

import Foundation
import CoreData

class NewsListViewModel: ObservableObject {
    @Published var groupedArticles: [String: [ArticleMetadata]] = [:]  // For reviewer
    @Published var authorArticles: [ArticleMetadata] = []              // For author
    @Published var selectedArticles: Set<NSManagedObjectID> = []
    @Published var isReviewer = true

    private var session: UserSession!
    private var context: NSManagedObjectContext!

    func loadArticles(context: NSManagedObjectContext) {
        self.context = context

        guard let session = UserDefaults.standard.getUserSession() else { return }
        self.session = session
        self.isReviewer = session.role == .reviewer

        if isReviewer {
            loadGroupedArticles()
        } else {
            loadAuthorArticles()
        }
    }

    private func loadGroupedArticles() {
        let fetchRequest: NSFetchRequest<ArticleMetadata> = ArticleMetadata.fetchRequest()
        do {
            let articles = try context.fetch(fetchRequest)
            groupedArticles = Dictionary(grouping: articles, by: { $0.author ?? "Unknown" })
        } catch {
            print("Error loading articles: \(error)")
        }
    }

    private func loadAuthorArticles() {
        let fetchRequest: NSFetchRequest<ArticleMetadata> = ArticleMetadata.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "author == %@", session.username)

        do {
            authorArticles = try context.fetch(fetchRequest)
        } catch {
            print("Error loading articles: \(error)")
        }
    }

    func toggleSelection(for id: NSManagedObjectID) {
        if selectedArticles.contains(id) {
            selectedArticles.remove(id)
        } else {
            selectedArticles.insert(id)
        }
    }

    func markSelectedArticlesApproved() {
        for id in selectedArticles {
            if let article = try? context.existingObject(with: id) as? ArticleMetadata,
               var approvedList = article.approvedBy as? [String] {
                if !approvedList.contains(session.username) {
                    approvedList.append(session.username)
                    article.approvedBy = approvedList as NSObject
                }
            }
        }
        try? context.save()
        selectedArticles.removeAll()
        loadGroupedArticles()
    }
}
