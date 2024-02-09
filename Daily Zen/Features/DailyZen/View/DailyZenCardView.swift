//
//  DailyZenCardView.swift
//  Daily Zen
//
//  Created by Aditya Kumrawat on 08/02/24.
//

import SwiftUI

import SwiftUI

struct DailyZenCardView: View {
    let detail: DailyZenDetail
    let screenWidth = UIScreen.main.bounds.size.width
    @State private var isShowingModal = false
    @EnvironmentObject var env: EnvironmentData
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading) {
                Text(detail.themeTitle)
                    .font(CustomFonts.semiBold(15))
                    .foregroundColor(env.theme.primaryTextColor)
                    .padding(16)
                
                RemoteImage(url: detail.dzImageUrl)
                    .frame(idealWidth: screenWidth, maxWidth: 400, idealHeight: screenWidth, maxHeight: 400)
                    .overlay(TopBottomBorder().stroke(env.theme.borderColor, lineWidth: 1))
                    .padding(-4)
                
                HStack {
                    Button(action:  {
                        isShowingModal = true
                    }) {
                        ZStack {
                            Circle()
                                .fill(env.theme.buttonBackgroundColor)
                                .frame(width: 30, height: 30)
                            Image(systemName: "square.and.arrow.up")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 20, height: 20)
                        }
                    }
                    
                    ZStack {
                        Circle()
                            .fill(env.theme.buttonBackgroundColor)
                            .frame(width: 30, height: 30)
                        Image(systemName: "plus.circle")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20, height: 20)
                    }
                    
                    ZStack {
                        Circle()
                            .fill(env.theme.buttonBackgroundColor)
                            .frame(width: 30, height: 30)
                        Image(systemName: "bookmark")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20, height: 20)
                    }
                }
                .padding(16)
                CustomShareView(isShowingModal: $isShowingModal, imageUrl: detail.dzImageUrl)
            }
            .background(env.theme.primaryBackgroundColor)
            .cornerRadius(12)
            .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.1), radius: 9)
            .frame(maxWidth: .infinity)
        }
        .frame(height: screenWidth + 89)
        .padding(16)
    }
    
    func extractURLs(from text: String) -> [URL] {
        do {
            let pattern = #"((?:https?|ftp)://\S+)"#
            let regex = try NSRegularExpression(pattern: pattern, options: .caseInsensitive)
            let range = NSRange(text.startIndex..<text.endIndex, in: text)
            let matches = regex.matches(in: text, options: [], range: range)
            
            let urls = matches.compactMap { match in
                let urlRange = match.range(at: 0)
                if let range = Range(urlRange, in: text) {
                    return URL(string: String(text[range]))
                }
                return nil
            }
            return urls
        } catch {
            return []
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
