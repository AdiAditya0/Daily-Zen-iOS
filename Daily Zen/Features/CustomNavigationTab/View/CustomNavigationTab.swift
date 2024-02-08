import SwiftUI

struct CustomNavigationTab: View {
    var body: some View {
        NavigationView {
            DailyZenView(viewModel: DailyZenViewModel())
            .navigationBarItems(
                leading:
                    Button(action: {
                        print("Left Button Tapped")
                    }) {
                        Text("Previous")
                    }
                    .foregroundColor(.blue)
                ,
                trailing:
                    Button(action: {
                        print("Right Button Tapped")
                    }) {
                        Text("Next")
                    }
                    .foregroundColor(.blue)
            )
            .navigationBarTitle("Today", displayMode: .inline)
            .labelsHidden()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CustomNavigationTab()
    }
}
