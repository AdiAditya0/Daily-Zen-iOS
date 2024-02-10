import SwiftUI

struct CustomFonts {
    static func regular(_ size: CGFloat) -> Font {
        return Font.custom("Inter", size: size)
    }
    
    static func medium(_ size: CGFloat) -> Font {
        return Font.custom("Inter-Medium", size: size)
    }
    
    static func semiBold(_ size: CGFloat) -> Font {
        return Font.custom("Inter-SemiBold", size: size)
    }
}
