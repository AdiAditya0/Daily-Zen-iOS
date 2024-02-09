import Foundation
import SwiftUI

protocol Theme {
    var primaryColor: Color { get }
    var secondaryColor: Color { get }
    var primaryTextColor: Color { get }
    var secondaryTextColor: Color { get }
    var primaryBackgroundColor: Color { get }
    var secondaryBackgroundColor: Color { get }
    var buttonBackgroundColor: Color { get }
    var borderColor: Color { get }
}

struct DarkTheme: Theme {
    let primaryColor: Color = Color(hex: "")
    let secondaryColor: Color = Color(hex: "")
    let primaryTextColor: Color = Color(hex: "#FFFFFF")
    let secondaryTextColor: Color = Color(hex: "#EBEBF5")
    let primaryBackgroundColor: Color = Color(hex: "#000000")
    let secondaryBackgroundColor: Color = Color(hex: "#1C1C1E")
    let buttonBackgroundColor: Color = Color(hex: "#2C2C2E")
    let borderColor: Color = Color(hex: "#C6C6C84D")
}

struct LightTheme: Theme {
    let primaryColor: Color = Color(hex: "")
    let secondaryColor: Color = Color(hex: "")
    let primaryTextColor: Color = Color(hex: "#000000")
    let secondaryTextColor: Color = Color(hex: "#3C3C43")
    let primaryBackgroundColor: Color = Color(hex: "#FFFFFF")
    let secondaryBackgroundColor: Color = Color(hex: "#C6C6C8")
    let buttonBackgroundColor: Color = Color(hex: "#F2F2F7")
    let borderColor: Color = Color(hex: "#C6C6C84D")
}
