//
//  Structs.swift
//  WallpaperApp
//
//  Created by spark-02 on 2024/07/02.
//

import Foundation

struct UnsplashPhoto: Codable {
    let user: User
    let urls: Urls
    let updatedAt: String
    let location: Location?
    
    enum CodingKeys: String, CodingKey {
        case user
        case urls
        case updatedAt = "updated_at"
        case location
    }
}

struct User: Codable {
    let name: String
    let links: UserLinks
}

struct UserLinks: Codable {
    let html: String
}

struct Urls: Codable {
    let full: String
}

struct Location: Codable {
    let name: String?
}



