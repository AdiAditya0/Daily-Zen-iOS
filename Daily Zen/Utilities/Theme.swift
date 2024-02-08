import Foundation
import SwiftUI

protocol ThemeColors {
    var primaryColor: Color { get }
    var secondaryColor: Color { get }
    var primaryBackgroundColor: Color { get }
    var secondaryBackgroundColor: Color { get }
}

struct DarkTheme: ThemeColors {
    let primaryColor: Color = Color(hex: "")
    let secondaryColor: Color = Color(hex: "")
    let primaryBackgroundColor: Color = Color(hex: "")
    let secondaryBackgroundColor: Color = Color(hex: "")
}

struct LightTheme: ThemeColors {
    let primaryColor: Color = Color(hex: "")
    let secondaryColor: Color = Color(hex: "")
    let primaryBackgroundColor: Color = Color(hex: "")
    let secondaryBackgroundColor: Color = Color(hex: "")
}

struct Theme {
    let primaryColor: Color
    let secondaryColor: Color
    let primaryBackgroundColor: Color
    let secondaryBackgroundColor: Color
    
    init(colorScheme: ColorScheme) {
        let theme: ThemeColors = colorScheme == .light ? LightTheme() : DarkTheme()
        primaryColor = theme.primaryColor
        secondaryColor = theme.secondaryColor
        primaryBackgroundColor = theme.primaryBackgroundColor
        secondaryBackgroundColor = theme.secondaryBackgroundColor
    }
}
