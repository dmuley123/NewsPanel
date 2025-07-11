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
        let ids = await fetchAllArticleIDs()

        for id in ids {
            guard let detail = await fetchArticleDetail(id: id) else { continue }

            // Handle ArticleMetadata
            let metaReq: NSFetchRequest<ArticleMetadata> = ArticleMetadata.fetchRequest()
            metaReq.predicate = NSPredicate(format: "id == %@", id)
            let existingMeta = try context.fetch(metaReq).first ?? ArticleMetadata(context: context)

            existingMeta.id = id
            existingMeta.author = MockData.getMockMetadata().first(where: { $0.id == id })?.author ?? "Unknown"
            existingMeta.summary = MockData.getMockMetadata().first(where: { $0.id == id })?.summary
            if existingMeta.approvedBy == nil {
                existingMeta.approvedBy = [] as NSObject
            }

            // Handle ArticleDetail
            let detailReq: NSFetchRequest<ArticleDetail> = ArticleDetail.fetchRequest()
            detailReq.predicate = NSPredicate(format: "id == %@", id)
            let existingDetail = try context.fetch(detailReq).first ?? ArticleDetail(context: context)

            existingDetail.id = id
            existingDetail.fullContent = detail.fullContent
        }

        try context.save()

        // Simulate sending PUT request back to server
        let all = try context.fetch(ArticleMetadata.fetchRequest()) as? [ArticleMetadata] ?? []
        await putMergedArticles(all)
    }

    
    func fetchAllArticleIDs() async -> [String] {
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        return ["1", "2", "3"]
    }

    func fetchArticleDetail(id: String) async -> ArticleDetailData? {
        try? await Task.sleep(nanoseconds: 500_000_000)
        return MockData.getMockDetail(for: id)
    }

    func putMergedArticles(_ articles: [ArticleMetadata]) async {
        // Simulate a PUT call
        print("PUT to server with \(articles.count) articles.")
    }

}

