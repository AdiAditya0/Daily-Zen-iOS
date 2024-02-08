import Foundation

struct DailyZenDetail: Codable, Hashable {
    let text: String
    let author: String
    let uniqueId: String
    let dzType: String
    let themeTitle: String
    let articleUrl: String?
    let dzImageUrl: String
    let primaryCTAText: String
    let sharePrefix: String
    var dateString: String?
}

extension DailyZenDetail {
    init(dailyZenDetailMo: DailyZenDetailMo) {
        self.text = dailyZenDetailMo.text ?? ""
        self.author = dailyZenDetailMo.author ?? ""
        self.dateString = dailyZenDetailMo.dateString ?? ""
        self.uniqueId = dailyZenDetailMo.uniqueId ?? ""
        self.dzType = dailyZenDetailMo.dzType ?? ""
        self.themeTitle = dailyZenDetailMo.themeTitle ?? ""
        self.articleUrl = dailyZenDetailMo.articleUrl ?? ""
        self.dzImageUrl = dailyZenDetailMo.dzImageUrl ?? ""
        self.primaryCTAText = dailyZenDetailMo.primaryCTAText ?? ""
        self.sharePrefix = dailyZenDetailMo.sharePrefix ?? ""
    }
}
