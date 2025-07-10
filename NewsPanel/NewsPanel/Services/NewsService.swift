//
//  NewsService.swift
//  NewsPanel
//
//  Created by Dnyaneshwar Muley on 10/07/25.
//

import Foundation
import CoreData

class NewsService {
    static let shared = NewsService()

    private init() {}

    func syncArticles(context: NSManagedObjectContext) async throws {
        try await Task.sleep(nanoseconds: 2_000_000_000) // simulate 2 sec delay

        let mockArticles = MockData.getMockMetadata()

        for article in mockArticles {
            let fetchRequest: NSFetchRequest<ArticleMetadata> = ArticleMetadata.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == %@", article.id)

            let existing = try context.fetch(fetchRequest).first

            if existing == nil {
                let newArticle = ArticleMetadata(context: context)
                newArticle.id = article.id
                newArticle.author = article.author
                newArticle.summary = article.summary
                // newArticle.approvedBy = []
                
            }
        }

        try context.save()
    }
}

