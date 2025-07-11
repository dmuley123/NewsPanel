//
//  MockData.swift
//  NewsPanel
//
//  Created by Dnyaneshwar Muley on 10/07/25.
//

import Foundation

struct MockData {
    static func getMockMetadata() -> [ArticleSummary] {
        return [
            ArticleSummary(id: "1", author: "Robert", summary: "SwiftUI 3.0 tips", approveCount: 5),
            ArticleSummary(id: "2", author: "Alice", summary: "AI in Aviation", approveCount: 3),
            ArticleSummary(id: "3", author: "Robert", summary: "Offline-first apps", approveCount: 7)
        ]
    }
}

struct ArticleSummary {
    let id: String
    let author: String
    let summary: String
    let approveCount: Int
}

// MARK: - Full Articles

extension MockData {
    static func getMockDetail(for id: String) -> ArticleDetailData? {
        let data: [String: String] = [
            "1": "iOS 18 introduces a set of improvements to SwiftUI including animations and layout.",
            "2": "AI is now reshaping the aviation sector through predictive maintenance.",
            "3": "Offline-first apps require syncing strategies and caching techniques."
        ]
        guard let content = data[id] else { return nil }
        return ArticleDetailData(id: id, fullContent: content)
    }
}

struct ArticleDetailData {
    let id: String
    let fullContent: String
}

struct ArticleMetaDataJSON: Codable {
    let articleId: String
    let author: String
    let approveCount: Int
    let summary: String
}

extension MockData {
    static func getMockArticleMetadataJSON() -> Data {
        let mockArray: [ArticleMetaDataJSON] = [
            .init(articleId: "1", author: "Robert", approveCount: 5, summary: "SwiftUI 3.0 tips"),
            .init(articleId: "2", author: "Alice", approveCount: 3, summary: "AI in Aviation"),
            .init(articleId: "3", author: "Robert", approveCount: 7, summary: "Offline-first apps")
        ]

        return try! JSONEncoder().encode(mockArray)
    }
}

struct ArticleDetailJSON: Codable {
    let articleId: String
    let name: String
    let article: String
    let createdAt: String
    let updatedAt: String
    let approvedBy: [String]
}

extension MockData {
    static func getMockArticleDetailJSON(for id: String) -> Data? {
        let detail = ArticleDetailJSON(
            articleId: id,
            name: "Perfume",
            article: "Perfumes are made from essential oils and aroma compounds",
            createdAt: "2024-12-01T10:30:00Z",
            updatedAt: "2025-06-25T09:15:00Z",
            approvedBy: ["Mark", "Jhon"]
        )
        return try? JSONEncoder().encode(detail)
    }
}
