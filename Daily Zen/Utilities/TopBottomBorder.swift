import SwiftUI

struct TopBottomBorder: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let lineWidth: CGFloat = 1
        let topBorder = CGRect(x: 0, y: 0, width: rect.width, height: lineWidth)
        let bottomBorder = CGRect(x: 0, y: rect.height - lineWidth, width: rect.width, height: lineWidth)
        path.addRect(topBorder)
        path.addRect(bottomBorder)
        return path
    }
}
