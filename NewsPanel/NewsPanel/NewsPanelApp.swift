//
//  NewsPanelApp.swift
//  NewsPanel
//
//  Created by Dnyaneshwar Muley on 10/07/25.
//

import SwiftUI

@main
struct NewsPanelApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            LoginView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
