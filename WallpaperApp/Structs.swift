import Foundation

struct UnsplashPhoto: Codable {
    let user: User
    let urls: Urls
    let updatedAt: String
    var ja: String?
    let alternativeslags: [String: String?]
    
    enum CodingKeys: String, CodingKey {
        case user
        case urls
        case updatedAt = "updated_at"
        case ja
        case alternativeslags = "alternative_slugs"
    }
}

struct User: Codable {
    let username: String
    let name: String
    let links: UserLinks
    let location: String?
}

struct UserLinks: Codable {
    let html: String
}

struct Urls: Codable {
    let full: String
    let regular: String
    let thumb: String
}

struct UnsplashPhotos: Decodable {
    let id: String
    let urls: UnsplashPhotoURLs
}

struct UnsplashPhotoURLs: Decodable {
    let regular: String
}

struct UnsplashResponse: Decodable {
    let results: [UnsplashPhoto]
}

