import SwiftUI
import CoreData
import Foundation

struct NavigationContent: View {
    @ObservedObject var viewModel: DailyZenViewModel
    @EnvironmentObject var env: EnvironmentData
    
    var body: some View {
        ZStack {
            List {
                ForEach(viewModel.dailyZenDetails ?? [], id: \.self) { detail in
                    DailyZenCardView(detail: detail)
                    .padding(0)
                    .listRowInsets(EdgeInsets())
                    .listRowSeparator(.hidden)
                }
                HStack{
                    Spacer()
                    VStack {
                        Image("person")
                            .resizable()
                            .frame(width: 127, height: 128)
                        Text("That’s the Zen for today!\nSee you tomorrow :)")
                            .font(CustomFonts.regular(14))
                            .foregroundColor(env.theme.secondaryTextColor)
                            .multilineTextAlignment(.center)
                    }
                    .padding(.vertical, 50)
                    Spacer()
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
                HStack {
                    Image(systemName: "chevron.left")
                        .renderingMode(.template)
                        .foregroundColor(Color(hex: "#EA436B"))
                        .frame(width: 16, height: 28)
                    Text("Previous")
                        .font(CustomFonts.regular(17))
                        .foregroundColor(Color(hex: "#EA436B"))
                        .padding(.leading, -5)
                    
                }
            }
                .foregroundColor(.blue))

            ,
            trailing: viewModel.currentDayDiff == 0
            ? AnyView(EmptyView())
            : AnyView(              Button(action: {
                viewModel.fetchDataNextDate()
            }) {
                HStack {
                    Text("Next")
                        .font(CustomFonts.regular(17))
                        .foregroundColor(Color(hex: "#EA436B"))
                        .padding(.trailing, -5)
                    Image(systemName: "chevron.right")
                        .renderingMode(.template)
                        .foregroundColor(Color(hex: "#EA436B"))
                        .frame(width: 16, height: 28)
                    
                }
            }
                .foregroundColor(.blue))
        )
        .navigationBarTitle(viewModel.getBarTitle(), displayMode: .inline)
        .labelsHidden()
    }
}

struct DailyZenView: View {
    @ObservedObject var viewModel: DailyZenViewModel
    
    var body: some View  {
        if #available(iOS 16.0, *) {
            NavigationStack {
                NavigationContent(viewModel: viewModel)
            }
            .onAppear {
                self.viewModel.startMonitoring()
            }
            .onDisappear {
                self.viewModel.stopMonitoring()
            }
        } else {
            NavigationView {
                NavigationContent(viewModel: viewModel)
            }
            .onAppear {
                self.viewModel.startMonitoring()
            }
            .onDisappear {
                self.viewModel.stopMonitoring()
            }
        }
    }
}
