//
//  DailyZenCardView.swift
//  Daily Zen
//
//  Created by Aditya Kumrawat on 08/02/24.
//

import SwiftUI

import SwiftUI

struct DailyZenCardView: View {
    let imageName: String
    let title: String
    let description: String
    let theme: Theme
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading) {
                Text(title)
                    .font(CustomFonts.semiBold(15))
                    .foregroundColor(theme.primaryTextColor)
                    .padding()
                
                Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: geometry.size.width - 52, height: 150)
                    .cornerRadius(12)
                    .padding(10)
                
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
                .padding()
            }
            .background(theme.secondaryBackgroundColor)
            .cornerRadius(12)
            .shadow(radius: 2)
            .padding(.horizontal, 10)
            .frame(maxWidth: .infinity)
        }
    }
}

struct DailyZenCardView_Previews: PreviewProvider {
    @Environment(\.colorScheme) var colorSchema
    
    static var previews: some View {
        DailyZenCardView(imageName: "exampleImage", title: "Example Title", description: "Example Description", theme: DarkTheme())
            .previewLayout(.sizeThatFits)
    }
}
