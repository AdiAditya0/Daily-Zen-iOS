import SwiftUI
import Foundation

struct SocialMediaButton: View {
    let title: String
    let image: String
    let action: () -> Void
    @EnvironmentObject var env: EnvironmentData
    
    var body: some View {
        Button(action: {
            action()
        }) {
            VStack {
                Image(image)
                    .frame(width: 44, height: 44)
                Text(title)
                    .font(CustomFonts.semiBold(11))
                    .foregroundColor(env.theme.primaryTextColor)
            }
        }
    }
}

struct ExtraButton: View {
    let title: String
    let image: String
    let action: () -> Void
    @EnvironmentObject var env: EnvironmentData
    
    var body: some View {
        Button(action: {
            action()
        }) {
            VStack {
                ZStack {
                    Circle()
                        .fill(env.theme.buttonBackgroundColor)
                        .frame(width: 44, height: 44)
                    Image(systemName: image)
                        .renderingMode(.template)
                        .foregroundColor(env.theme.labelColor)
                        .frame(width: 24, height: 24)
                }
                Text(title)
                    .font(CustomFonts.semiBold(11))
                    .foregroundColor(env.theme.primaryTextColor)
            }
        }
    }
}

struct PopupContent: View {
    @Binding var isShowingModal: Bool
    @State var isCopied = false
    @EnvironmentObject var env: EnvironmentData
    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    let detail: DailyZenDetail
    let imageSize = (UIScreen.main.bounds.size.width > 600 ? 600 : UIScreen.main.bounds.size.width - 32)
    
    var body: some View {
        HStack {
            Text(detail.primaryCTAText)
                .font(CustomFonts.semiBold(16))
                .foregroundColor(env.theme.primaryTextColor)
            Spacer()
            Button(action: {
                isShowingModal = false
            }) {
                ZStack {
                    Circle()
                        .fill(env.theme.buttonBackgroundColor)
                        .frame(width: 30, height: 30)
                    Image(UITraitCollection.current.userInterfaceStyle == .light ? "close" : "close-dark")
                        .frame(width: 18, height: 20)
                }
            }
        }
        
        Spacer()
        
        RemoteImage(url: detail.dzImageUrl)
            .frame(width: imageSize, height: imageSize)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(env.theme.borderColor, lineWidth: 1)
            )
            .cornerRadius(16)
        
        Spacer()
        
        HStack {
            Text(detail.text + " - " + detail.author)
                .font(CustomFonts.regular(16))
                .padding(16)
            Spacer()
            Button(action: {
                UIPasteboard.general.string = detail.text + " - " + detail.author
                isCopied = true
            }) {
                if isCopied {
                    Text("Copied")
                        .font(CustomFonts.regular(17))
                        .foregroundColor(Color(hex: "#FFFFFF"))
                        .padding(.vertical, 8.5)
                        .padding(.horizontal, 16)
                } else {
                    Text("Copy")
                        .font(CustomFonts.regular(17))
                        .foregroundColor(Color(hex: "#EA436B"))
                        .padding(.vertical, 8.5)
                        .padding(.horizontal, 16)
                }
            }
            .background(isCopied ? Color(hex: "#EA436B") : Color(hex: "#EA436B26"))
            .cornerRadius(34)
            .padding(.horizontal, 16)
        }
        .background(env.theme.secondaryBackgroundColor)
        .frame(height: 48)
        .cornerRadius(50)
        
        Spacer()
        
        VStack(alignment: .leading)  {
            Text("Share to")
                .font(CustomFonts.semiBold(15))
                .foregroundColor(env.theme.primaryTextColor)
                .padding(.vertical, 16)
            HStack {
                SocialMediaButton(title: "WhatsApp", image: "whatsapp-icon") {
                    shareOnWhatsApp()
                }
                Spacer()
                SocialMediaButton(title: "Instagram", image: "instagram-icon") {
                    shareOnInstagram()
                }
                Spacer()
                SocialMediaButton(title: "FaceBook", image: "facebook-icon") {
                    shareOnFacebook()
                }
                Spacer()
                ExtraButton(title: "Download", image: "square.and.arrow.down") {}
                Spacer()
                ExtraButton(title: "More", image: "ellipsis") {
                    moreOptions()
                }
            }
        }
        .overlay(TopBorder().stroke(env.theme.borderColor, lineWidth: 1))
        Spacer()
    }
    
    func shareOnWhatsApp() {
        let originalString = detail.sharePrefix + " " + (detail.articleUrl ?? "")
        if let encodedString = originalString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            let url = URL(string: "whatsapp://send?text=\(encodedString)&image=\(detail.dzImageUrl)")!
            
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                print("WhatsApp is not installed.")
            }
        }
    }
    
    func shareOnInstagram() {
        let originalString = detail.sharePrefix + " " + (detail.articleUrl ?? "")
        if let encodedString = originalString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            let url = URL(string: "instagram://library?caption=\(encodedString)&AssetPath=\(detail.dzImageUrl)")!
            
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                print("Instagram is not installed.")
            }
        }
    }
    
    func shareOnFacebook() {
        let originalString = detail.sharePrefix + " " + (detail.articleUrl ?? "")
        if let encodedString = originalString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            let url = URL(string: "fb://profile?app_scoped_user_id=&text=\(encodedString)&image=\(detail.dzImageUrl)")!
            
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                print("Facebook is not installed.")
            }
        }
    }
    
    func moreOptions() {
        isShowingModal = false
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
            let activityViewController = UIActivityViewController(
                activityItems: [detail.dzImageUrl, detail.sharePrefix + " " + (detail.articleUrl ?? "")],
                applicationActivities: nil)
            let tempView = UIView()
            if let popoverController = activityViewController.popoverPresentationController {
                popoverController.sourceView = tempView
                popoverController.sourceRect = CGRect(x: 0, y: 0, width: 0, height: 0)
            }
            UIApplication.shared.windows.first?.rootViewController?.present(activityViewController, animated: true, completion: nil)
        }
    }
}

struct CustomShareView: View {
    @Binding var isShowingModal: Bool
    let popupHeight = 300 + UIScreen.main.bounds.size.width
    let detail: DailyZenDetail
    
    var body: some View {
        VStack {}
            .padding(0)
            .sheet(isPresented: $isShowingModal) {
                if #available(iOS 16.0, *) {
                    VStack {
                        PopupContent(isShowingModal: $isShowingModal, detail: detail)
                    }
                    .padding(16)
                    .presentationDetents([.height(popupHeight)])
                } else {
                    VStack {
                        PopupContent(isShowingModal: $isShowingModal, detail: detail)
                    }
                    .padding(16)
                }
            }
    }
}
