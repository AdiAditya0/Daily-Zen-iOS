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
    let theme: Theme
    let screenWidth = UIScreen.main.bounds.size.width
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading) {
                Text(detail.themeTitle)
                    .font(CustomFonts.semiBold(15))
                    .foregroundColor(theme.primaryTextColor)
                    .padding(16)
                
                RemoteImage(url: detail.dzImageUrl)
                    .frame(idealWidth: screenWidth, maxWidth: 400, idealHeight: screenWidth, maxHeight: 400)
                    .overlay(TopBottomBorder().stroke(theme.borderColor, lineWidth: 1))
                    .padding(-4)
                
                HStack {
                    ZStack {
                        Circle()
                            .fill(theme.buttonBackgroundColor)
                            .frame(width: 30, height: 30)
                        Image(systemName: "square.and.arrow.up")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20, height: 20)
                    }
                    
                    ZStack {
                        Circle()
                            .fill(theme.buttonBackgroundColor)
                            .frame(width: 30, height: 30)
                        Image(systemName: "plus.circle")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20, height: 20)
                    }
                    
                    ZStack {
                        Circle()
                            .fill(theme.buttonBackgroundColor)
                            .frame(width: 30, height: 30)
                        Image(systemName: "bookmark")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20, height: 20)
                    }
                }
                .padding(16)
            }
            .background(theme.secondaryBackgroundColor)
            .cornerRadius(12)
            .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.1), radius: 9)
            .frame(maxWidth: .infinity)
        }
        .frame(height: screenWidth + 89)
        .padding(16)
    }
    
}

struct DailyZenCardView_Previews: PreviewProvider {
    @Environment(\.colorScheme) var colorSchema
    
    static var previews: some View {
        VStack{
            DailyZenCardView(detail: DailyZenDetail(text: "", author: "", uniqueId: "", dzType: "", themeTitle: "", articleUrl: "", dzImageUrl: "", primaryCTAText: "", sharePrefix: ""), theme: LightTheme())
                .previewLayout(.sizeThatFits)
            DailyZenCardView(detail: DailyZenDetail(text: "", author: "", uniqueId: "", dzType: "", themeTitle: "", articleUrl: "", dzImageUrl: "", primaryCTAText: "", sharePrefix: ""), theme: DarkTheme())
                .previewLayout(.sizeThatFits)
        }
    }
}
