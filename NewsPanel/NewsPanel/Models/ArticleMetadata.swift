//
//  ArticleMetadata.swift
//  NewsPanel
//
//  Created by Dnyaneshwar Muley on 10/07/25.
//

import Foundation
import CoreData

extension ArticleMetadata {
    static func fetchCount(context: NSManagedObjectContext) -> Int {
        let request: NSFetchRequest<ArticleMetadata> = ArticleMetadata.fetchRequest()
        do {
            return try context.count(for: request)
        } catch {
            return 0
        }
    }
}
