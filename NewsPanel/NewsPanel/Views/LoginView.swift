//
//  LoginView.swift
//  NewsPanel
//
//  Created by Dnyaneshwar Muley on 10/07/25.
//

import SwiftUI

struct LoginView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var username: String = ""
    @State private var alertMessage = ""
    
    @State private var showAlert = false
    @State private var isLoggedIn = false
    

    var body: some View {
        VStack(spacing: 20) {
            Text("Login")
                .font(.largeTitle)
                .bold()

            TextField("Enter Username", text: $username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)

            Button("Sync Articles") {
                Task {
                    await handleSync()
                }
            }
            .padding()
            .buttonStyle(.borderedProminent)

            Button("Login") {
                handleLogin()
            }
            .disabled(!isSynced())
            .padding()
            .buttonStyle(.bordered)
        }
        .alert("Warning", isPresented: $showAlert) {
            Button("OK", role: .cancel) {}
        } message: {
            Text(alertMessage)
        }
        .padding()
        .navigationDestination(isPresented: $isLoggedIn) {
            NewsListView()
        }
    }

    func handleSync() async {
        do {
            try await NewsService.shared.syncArticles(context: viewContext)
            alertMessage = "Sync successful!"
        } catch {
            alertMessage = "Failed to sync articles: \(error.localizedDescription)"
        }
        showAlert = true
    }

    func handleLogin() {
        let session = UserSession.from(username: username)
        UserDefaults.standard.saveUserSession(session)

        if isSynced() {
            isLoggedIn = true
        } else {
            alertMessage = "Please sync the app before logging in."
            showAlert = true
        }
    }

    func isSynced() -> Bool {
        return ArticleMetadata.fetchCount(context: viewContext) > 0
    }
}
