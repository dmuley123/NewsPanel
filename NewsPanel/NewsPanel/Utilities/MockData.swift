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
            ArticleSummary(id: "1", author: "Robert", summary: "iOS 18 introduces SwiftUI improvements"),
            ArticleSummary(id: "2", author: "Alice", summary: "AI integration in aviation industry"),
            ArticleSummary(id: "3", author: "Robert", summary: "Offline-first mobile app design tips")
        ]
    }
}

struct ArticleSummary {
    let id: String
    let author: String
    let summary: String
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
