//
//  NewsListViewModel.swift
//  NewsPanel
//
//  Created by Dnyaneshwar Muley on 10/07/25.
//

import Foundation
import CoreData

class NewsListViewModel: ObservableObject {
    @Published var authorArticles: [ArticleRowModel] = []
    @Published var groupedReviewerArticles: [String: [ArticleRowModel]] = [:]
    @Published var selectedArticles: Set<NSManagedObjectID> = []
    @Published var isReviewer = true
    
    private var session: UserSession!
    private var context: NSManagedObjectContext!
    private var fetchOffset = 0
    private let pageSize = 5
    private var allLoaded = false
    
    
    func loadArticles(context: NSManagedObjectContext) {
        self.context = context
        guard let session = UserDefaults.standard.getUserSession() else { return }
        self.session = session
        self.isReviewer = session.role == .reviewer
        
        if isReviewer {
            resetPagination()
            loadNextPage()
        } else {
            loadAuthorArticles()
        }
    }
    
    func loadNextPage() {
        guard !allLoaded else { return }
        
        let fetchRequest: NSFetchRequest<ArticleMetadata> = ArticleMetadata.fetchRequest()
        fetchRequest.fetchLimit = pageSize
        fetchRequest.fetchOffset = fetchOffset
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "author", ascending: true)]
        
        do {
            let metadataBatch = try context.fetch(fetchRequest)
            fetchOffset += metadataBatch.count
            allLoaded = metadataBatch.count < pageSize
            
            for metadata in metadataBatch {
                let rowVM = buildArticleRow(from: metadata, in: context)
                let author = rowVM.author
                groupedReviewerArticles[author, default: []].append(rowVM)
            }
            
        } catch {
            print("Pagination error: \(error.localizedDescription)")
        }
    }
    
    func buildArticleRow(from metadata: ArticleMetadata, in context: NSManagedObjectContext) -> ArticleRowModel {
        
        var fullContent = "No details available."
        
        print("Fetching detail for metadata ID: \(metadata.id ?? "-") → full content: \(fullContent.prefix(20))...")
        
        if let id = metadata.id {
            let fetchRequest: NSFetchRequest<ArticleDetail> = ArticleDetail.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == %@", id)
            
            if let detail = try? context.fetch(fetchRequest).first {
                fullContent = detail.body ?? "No details available."
            }
        }
        
        return ArticleRowModel(
            id: metadata.id ?? UUID().uuidString,
            author: metadata.author ?? "Unknown",
            summary: metadata.summary ?? "-",
            approveCount: Int(metadata.approveCount),
            fullContent: fullContent,
            objectID: metadata.objectID
        )
    }
    
    func resetPagination() {
        fetchOffset = 0
        groupedReviewerArticles = [:]
        allLoaded = false
    }
    
    func isLast(articleID: String) -> Bool {
        let all = groupedReviewerArticles.values.flatMap { $0 }
        return articleID == all.last?.id
    }
    
    func loadAuthorArticles() {
        let request: NSFetchRequest<ArticleMetadata> = ArticleMetadata.fetchRequest()
        request.predicate = NSPredicate(format: "author == %@", session.username)
        
        do {
            let result = try context.fetch(request)
            authorArticles = result.map { buildArticleRow(from: $0, in: context) }
        } catch {
            print("Author fetch error: \(error)")
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
        resetPagination()
        loadNextPage()
        selectedArticles.removeAll()
    }
}
