//
//  UserDefaults+Session.swift
//  NewsPanel
//
//  Created by Dnyaneshwar Muley on 10/07/25.
//

import Foundation

extension UserDefaults {
    func saveUserSession(_ session: UserSession) {
        set(session.username, forKey: "\(Constants.userDefaultsKey)_username")
        set(session.role.rawValue, forKey: "\(Constants.userDefaultsKey)_role")
    }

    func getUserSession() -> UserSession? {
        guard let username = string(forKey: "\(Constants.userDefaultsKey)_username"),
              let roleRaw = string(forKey: "\(Constants.userDefaultsKey)_role"),
              let role = UserRole(rawValue: roleRaw) else {
            return nil
        }
        return UserSession(username: username, role: role)
    }

    func clearUserSession() {
        removeObject(forKey: "\(Constants.userDefaultsKey)_username")
        removeObject(forKey: "\(Constants.userDefaultsKey)_role")
    }
}
