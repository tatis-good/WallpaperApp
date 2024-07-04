import Foundation

struct UnsplashPhoto: Codable {
    let user: User
    let urls: Urls
    let updatedAt: String
    
    enum CodingKeys: String, CodingKey {
        case user
        case urls
        case updatedAt = "updated_at"
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
    let regular: String
    let thumb: String
}

