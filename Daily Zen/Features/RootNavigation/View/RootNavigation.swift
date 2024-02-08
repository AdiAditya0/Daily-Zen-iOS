import SwiftUI

struct RootNavigation: View {
    var body: some View {
        NavigationStack {
            CustomNavigationTab()
        }
    }
}

struct RootNavigation_Previews: PreviewProvider {
    static var previews: some View {
        RootNavigation()
    }
}
