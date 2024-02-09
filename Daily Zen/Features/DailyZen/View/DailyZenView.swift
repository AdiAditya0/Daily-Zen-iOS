import SwiftUI
import CoreData

struct DailyZenView: View {
    @ObservedObject var viewModel: DailyZenViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                List {
                    ForEach(viewModel.dailyZenDetails ?? [], id: \.self) { detail in
                        DailyZenCardView(detail: detail)
                        .padding(0)
                        .listRowInsets(EdgeInsets())
                        .listRowSeparator(.hidden)
                    }
                }
                .listStyle(PlainListStyle())
                .padding(0)
                if viewModel.showLoader {
                    ProgressView()
                }
            }
            .onAppear {
                viewModel.fetchData(date: Date.now)
                viewModel.deleteOlderEntities()
            }
            .navigationBarItems(
                leading: viewModel.currentDayDiff > 6
                ? AnyView(EmptyView())
                : AnyView(Button(action: {
                    viewModel.fetchDataPreviousDate()
                }) {
                    Text("Previous")
                }
                    .foregroundColor(.blue))

                ,
                trailing: viewModel.currentDayDiff == 0
                ? AnyView(EmptyView())
                : AnyView(              Button(action: {
                    viewModel.fetchDataNextDate()
                }) {
                    Text("Next")
                }
                    .foregroundColor(.blue))
            )
            .navigationBarTitle("Today", displayMode: .inline)
            .labelsHidden()
        }
        .onAppear {
            self.viewModel.startMonitoring()
        }
        .onDisappear {
            self.viewModel.stopMonitoring()
        }
    }
}
