import SwiftUI

struct DailyZenCardView: View {
    let detail: DailyZenDetail
    let screenWidth = UIScreen.main.bounds.size.width
    let imageSize = (UIScreen.main.bounds.size.width > 600 ? 568 : UIScreen.main.bounds.size.width - 32)
    @State private var isShowingModal = false
    @EnvironmentObject var env: EnvironmentData
    
    var body: some View {
        VStack(alignment: .leading) {
            CustomShareView(isShowingModal: $isShowingModal, detail: detail)
            Text(detail.themeTitle)
                .font(CustomFonts.semiBold(15))
                .foregroundColor(env.theme.secondaryTextColor)
                .padding(16)
            
            RemoteImage(url: detail.dzImageUrl)
                .frame(width: imageSize, height: imageSize)
                .overlay(TopBottomBorder().stroke(env.theme.borderColor, lineWidth: 1))
                .padding(-4)
            HStack {
                if detail.dzType == "read", let articleUrl = detail.articleUrl, !articleUrl.isEmpty {
                    HStack {
                        Image(systemName: "doc.text")
                            .renderingMode(.template)
                            .foregroundColor(env.theme.labelColor)
                            .frame(width: 18, height: 19)
                        Text("Read Full Post")
                            .font(CustomFonts.regular(17))
                            .foregroundColor(env.theme.secondaryTextColor)
                            .padding(.vertical, 8.5)
                    }
                    .padding(.horizontal, 16)
                    .background(env.theme.secondaryBackgroundColor)
                    .cornerRadius(34)
                    .onTapGesture {
                        openExternalBrowser(withURL: articleUrl)
                    }
                }
                
                ZStack {
                    Circle()
                        .fill(env.theme.buttonBackgroundColor)
                        .frame(width: 30, height: 30)
                    Image(systemName: "square.and.arrow.up")
                        .renderingMode(.template)
                        .foregroundColor(env.theme.labelColor)
                        .frame(width: 20, height: 20)
                }
                .onTapGesture {
                    isShowingModal = true
                }
                
                if detail.dzType == "add_affn" {
                    ZStack {
                        Circle()
                            .fill(env.theme.buttonBackgroundColor)
                            .frame(width: 30, height: 30)
                        Image(systemName: "plus.circle")
                            .renderingMode(.template)
                            .foregroundColor(env.theme.labelColor)
                            .frame(width: 20, height: 20)
                    }
                }
                
                ZStack {
                    Circle()
                        .fill(env.theme.buttonBackgroundColor)
                        .frame(width: 30, height: 30)
                    Image(systemName: "bookmark")
                        .renderingMode(.template)
                        .foregroundColor(env.theme.labelColor)
                        .frame(width: 20, height: 20)
                }
                
            }
            .padding(16)
        }
        .background(env.theme.primaryBackgroundColor)
        .cornerRadius(12)
        .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.1), radius: 9)
        .frame(maxWidth: .infinity)
        .frame(height: imageSize + 121)
        .padding(16)
    }
    
    func openExternalBrowser(withURL url: String) {
        if let url = URL(string: url), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            print("Invalid URL or browser not available.")
        }
    }
}

struct DailyZenCardView_Previews: PreviewProvider {
    
    static var previews: some View {
        VStack{
            DailyZenCardView(detail: DailyZenDetail(text: "", author: "", uniqueId: "", dzType: "", themeTitle: "", articleUrl: "", dzImageUrl: "", primaryCTAText: "", sharePrefix: ""))
                .previewLayout(.sizeThatFits)
        }
    }
}
