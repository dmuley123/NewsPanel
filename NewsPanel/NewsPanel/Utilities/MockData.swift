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
