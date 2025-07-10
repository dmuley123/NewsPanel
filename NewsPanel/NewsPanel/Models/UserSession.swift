//
//  UserSession.swift
//  NewsPanel
//
//  Created by Dnyaneshwar Muley on 10/07/25.
//

import Foundation

enum UserRole: String {
    case author
    case reviewer
}

struct UserSession {
    let username: String
    let role: UserRole

    static func from(username: String) -> UserSession {
        let role: UserRole = username == Constants.authorUsername ? .author : .reviewer
        return UserSession(username: username, role: role)
    }
}
