import SwiftUI
import Combine

@main
struct Daily_ZenApp: App {
    @StateObject var env = EnvironmentData()
    
    var body: some Scene {
        WindowGroup {
            RootNavigation().environmentObject(env)
                .onAppear {
                    let currentSystemScheme = UITraitCollection.current.userInterfaceStyle
                    env.updateEnvironment(isLight: currentSystemScheme == .light)
                }
        }
    }
}
