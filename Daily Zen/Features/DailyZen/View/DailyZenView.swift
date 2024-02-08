import SwiftUI
import CoreData

struct DailyZenView: View {
    @ObservedObject var viewModel: DailyZenViewModel
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        DailyZenCardView(imageName: "exampleImage", title: "Example Title", description: "Example Description", theme: colorScheme == .light ? LightTheme() : DarkTheme())
    }
}
