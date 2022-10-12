
import Foundation


struct TopPhotos: Codable {
    let photos: Photos?
    let stat: String?
}

// MARK: - Extra
struct Extra: Codable {
    let exploreDate: String?
    let nextPreludeInterval: Int?

    enum CodingKeys: String, CodingKey {
        case exploreDate = "explore_date"
        case nextPreludeInterval = "next_prelude_interval"
    }
}

// MARK: - Photos
struct Photos: Codable {
    let page, pages, perpage, total: Int?
    let photo: [Photo]?
}

// MARK: - Photo
struct Photo: Codable {
    let id, owner, secret, server: String?
    let farm: Int?
    let title: String?
    let ispublic, isfriend, isfamily: Int?
    let urlS: String?
    let heightS, widthS: Int?

    enum CodingKeys: String, CodingKey {
        case id, owner, secret, server, farm, title, ispublic, isfriend, isfamily
        case urlS = "url_s"
        case heightS = "height_s"
        case widthS = "width_s"
    }
}
