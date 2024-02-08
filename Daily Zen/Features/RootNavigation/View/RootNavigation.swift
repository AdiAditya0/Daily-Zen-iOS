import SwiftUI

struct RootNavigation: View {
    var body: some View {
        DailyZenView(viewModel: DailyZenViewModel())
    }
}

struct RootNavigation_Previews: PreviewProvider {
    static var previews: some View {
        RootNavigation()
    }
}
