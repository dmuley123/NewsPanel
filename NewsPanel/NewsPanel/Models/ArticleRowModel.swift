//
//  ArticleRowModel.swift
//  NewsPanel
//
//  Created by Dnyaneshwar Muley on 11/07/25.
//

import Foundation
import CoreData

struct ArticleRowModel: Identifiable {
    let id: String
    let author: String
    let summary: String
    let approveCount: Int
    let fullContent: String
    let objectID: NSManagedObjectID
}
