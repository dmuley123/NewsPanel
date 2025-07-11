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

    func fetchAllArticleIDs() async -> [String] {
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        return ["1", "2", "3"]
    }

    func fetchArticleDetail(for id: String, context: NSManagedObjectContext) async throws {
        try await Task.sleep(nanoseconds: 2_000_000_000)

        guard let jsonData = MockData.getMockArticleDetailJSON(for: id) else {
            throw NSError(domain: "Mock", code: 404, userInfo: [NSLocalizedDescriptionKey: "No mock for ID \(id)"])
        }

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let detail = try decoder.decode(ArticleDetailJSON.self, from: jsonData)

        let request: NSFetchRequest<ArticleDetail> = ArticleDetail.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", detail.articleId)
        let existing = try context.fetch(request).first ?? ArticleDetail(context: context)

        existing.id = detail.articleId
        existing.title = detail.name
        existing.body = detail.article
        existing.createdAt = ISO8601DateFormatter().date(from: detail.createdAt)
        existing.updatedAt = ISO8601DateFormatter().date(from: detail.updatedAt)
        existing.approvedBy = detail.approvedBy as NSObject

        try context.save()
    }

    func syncArticles(context: NSManagedObjectContext) async throws {
        let ids = await fetchAllArticleIDs()
        let summaries = MockData.getMockMetadata()
        let summaryMap = Dictionary(uniqueKeysWithValues: summaries.map { ($0.id, $0) })

        for id in ids {
            let request: NSFetchRequest<ArticleMetadata> = ArticleMetadata.fetchRequest()
            request.predicate = NSPredicate(format: "id == %@", id)
            let metadata = try context.fetch(request).first ?? ArticleMetadata(context: context)

            metadata.id = id
            metadata.author = summaryMap[id]?.author ?? "Unknown"
            metadata.summary = summaryMap[id]?.summary ?? "-"
            metadata.approveCount = Int16(summaryMap[id]?.approveCount ?? 0)
            if metadata.approvedBy == nil {
                metadata.approvedBy = [] as NSObject
            }

            try await fetchArticleDetail(for: id, context: context)
        }

        try context.save()
        print("✅ Sync complete: \(ids.count) articles synced")
    }
}
