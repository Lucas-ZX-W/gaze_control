import SwiftUI

@main
struct GazeControlApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                IntroView()
            }
            .navigationViewStyle(.stack)
        }
    }
}
