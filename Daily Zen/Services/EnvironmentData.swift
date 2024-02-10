import SwiftUI
import Combine

class EnvironmentData: ObservableObject {
    @Published var theme: Theme = LightTheme()
    
    func updateEnvironment(isLight: Bool) {
        if isLight {
            theme = LightTheme()
        } else {
            theme = DarkTheme()
        }
    }
}
