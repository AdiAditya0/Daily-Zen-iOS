import SwiftUI
import CoreData

struct DailyZenView: View {
    @ObservedObject var viewModel: DailyZenViewModel
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        List {
            ForEach(viewModel.dailyZenDetails ?? [], id: \.self) { detail in
                DailyZenCardView(
                    detail: detail,
                    theme: colorScheme == .light ? LightTheme() : DarkTheme()
                )
                .padding(0)
                .listRowInsets(EdgeInsets())
                .listRowSeparator(.hidden)
            }
        }
        .listStyle(PlainListStyle())
        .padding(0)
        .onAppear {
            viewModel.fetchData()
        }
    }
}
