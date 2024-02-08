import Foundation

struct DailyZenDetail: Codable, Hashable {
    let text: String
    let author: String
    let id: String
    let dzType: String
    let themeTitle: String
    let articleUrl: String?
    let dzImageUrl: String
    let primaryCTAText: String
    let sharePrefix: String
    
    enum CodingKeys: String, CodingKey {
        case text, author
        case id = "uniqueId"
        case dzType, dzImageUrl
        case themeTitle, articleUrl
        case primaryCTAText, sharePrefix
    }
}
