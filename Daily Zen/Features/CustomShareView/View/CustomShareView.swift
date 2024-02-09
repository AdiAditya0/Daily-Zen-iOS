import SwiftUI

struct SocialMediaButton: View {
    let title: String
    let image: String
    @EnvironmentObject var env: EnvironmentData
    
    var body: some View {
        Button(action: {
            
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
    @EnvironmentObject var env: EnvironmentData
    
    var body: some View {
        Button(action: {
            
        }) {
            VStack {
                ZStack {
                    Circle()
                        .fill(env.theme.buttonBackgroundColor)
                        .frame(width: 44, height: 44)
                    Image(systemName: image)
                        .frame(width: 24, height: 24)
                }
                Text(title)
                    .font(CustomFonts.semiBold(11))
                    .foregroundColor(env.theme.primaryTextColor)
            }
        }
    }
}

struct CustomShareView: View {
    @Binding var isShowingModal: Bool
    @EnvironmentObject var env: EnvironmentData
    let screenWidth = UIScreen.main.bounds.size.width
    let imageUrl: String
    
    var body: some View {
        VStack {}
            .padding(0)
            .sheet(isPresented: $isShowingModal) {
                VStack {
                    HStack {
                        Text("Inspire your friends")
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
                    
                    RemoteImage(url: imageUrl)
                        .frame(idealWidth: screenWidth, maxWidth: 400, idealHeight: screenWidth, maxHeight: 400)
                        .cornerRadius(16)
                    
                    HStack {
                        Text("dcasda")
                            .font(CustomFonts.regular(16))
                            .padding(16)
                        Spacer()
                        Button(action: {
                            
                        }) {
                            Text("Copy")
                                .background(.red)
                                .font(CustomFonts.regular(17))
                                .padding(8.5)
                                .cornerRadius(34)
                        }
                        .padding(.horizontal, 16)
                    }
                    .background(env.theme.secondaryBackgroundColor)
                    .frame(height: 48)
                    .cornerRadius(50)
                    
                    VStack(alignment: .leading)  {
                        Text("Share to")
                            .font(CustomFonts.semiBold(15))
                            .foregroundColor(env.theme.primaryTextColor)
                            .padding(.vertical, 16)
                        HStack {
                            SocialMediaButton(title: "WhatsApp", image: "whatsapp-icon")
                            Spacer()
                            SocialMediaButton(title: "Instagram", image: "instagram-icon")
                            Spacer()
                            SocialMediaButton(title: "FaceBook", image: "facebook-icon")
                            Spacer()
                            ExtraButton(title: "Download", image: "square.and.arrow.down")
                            Spacer()
                            ExtraButton(title: "More", image: "ellipsis")
                        }
                    }
                    .overlay(TopBorder().stroke(env.theme.borderColor, lineWidth: 1))
                }
                .padding(16)
                .presentationDetents([.height(600)])
                
            }
    }
    
    func shareOnWhatsApp() {
        let whatsappURL = URL(string: "whatsapp://send?text=Hello%2C%20this%20is%20a%20shared%20text%20message.%20%F0%9F%98%8A&image=https://example.com/image.jpg")!
        
        if UIApplication.shared.canOpenURL(whatsappURL) {
            UIApplication.shared.open(whatsappURL, options: [:], completionHandler: nil)
        } else {
            print("WhatsApp is not installed.")
        }
    }
    
    func shareOnInstagram() {
        let instagramURL = URL(string: "instagram://library?AssetPath=https://example.com/image.jpg&caption=Hello%2C%20this%20is%20a%20shared%20text%20message.%20%F0%9F%98%8A")!
        
        if UIApplication.shared.canOpenURL(instagramURL) {
            UIApplication.shared.open(instagramURL, options: [:], completionHandler: nil)
        } else {
            print("Instagram is not installed.")
        }
    }
    
    func shareOnFacebook() {
        let facebookURL = URL(string: "fb://profile?app_scoped_user_id=&text=Hello%2C%20this%20is%20a%20shared%20text%20message.%20%F0%9F%98%8A&image=https://example.com/image.jpg")!
        
        if UIApplication.shared.canOpenURL(facebookURL) {
            UIApplication.shared.open(facebookURL, options: [:], completionHandler: nil)
        } else {
            print("Facebook is not installed.")
        }
    }
}
