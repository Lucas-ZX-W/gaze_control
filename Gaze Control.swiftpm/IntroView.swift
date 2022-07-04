import SwiftUI

struct IntroView: View {
    @State var nextButtonDisabled: Bool = true
    
    var body: some View {
        VStack(spacing: 15) {
            Image(systemName: "eyes")
                .imageScale(.large)
                .foregroundColor(.accentColor)
                .font(.system(size: 169))
            Text("Look at me, look at you!")
                .font(.largeTitle)
            Text("This app is all about using your eyes! So get ready to use them!")
            Text("Note: This app is designed to be ran in Swift Playgrounds as a standalone app. Due to its content, it's best to experience it in full screen rather than the app Preview. Don't worry, you'll still get the chance to tweak values and experiment!")
                .font(.caption2)
            Text("Also, please choose one orientation (landscape or portrait) and don't change it throughout the app (lock your orientation please! This is to ensure that the initial calibration does not break throughout the app's usage.")
            NavigationLink(destination: WhatIsAccessibilityView()) {
                Text("-> So, what's so important about gaze? ->")
            }
            .disabled(nextButtonDisabled)
        }
        .padding(30)
        .onAppear() {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                nextButtonDisabled = false
            }
        }
    }
}
