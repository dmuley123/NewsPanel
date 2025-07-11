//
//  Constants.swift
//  NewsPanel
//
//  Created by Dnyaneshwar Muley on 10/07/25.
//

import Foundation

struct Constants {
    static let authorUsername = "Robert"
    static let userDefaultsKey = "LoggedInUser"
}

extension String {
    func toDate() -> Date? {
        ISO8601DateFormatter().date(from: self)
    }
}
