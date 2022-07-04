//
//  File.swift
//  Gaze Control
//
//  Created by Lucas Wang on 4/23/22.
//

import SwiftUI

struct WhatIsAccessibilityView: View {
    @State var nextButtonDisabled: Bool = true
    
    var body: some View {
        VStack(spacing: 5) {
            VStack(spacing: 15) {
                Image("icon_accessibility")
                Text("Accessibility")
                    .font(.largeTitle)
                    .foregroundColor(.pink)
                Label("Make it yours.", systemImage: "figure.wave")
                Label("Make it big.", systemImage: "rectangle.and.text.magnifyingglass")
                Label("Make it clear.", systemImage: "hearingdevice.ear")
                Label("Make it speak.", systemImage: "speaker.wave.3.fill")
                Label("Make it listen.", systemImage: "ear.and.waveform")
                Label("Make it simple.", systemImage: "figure.walk")
                Text("↑ Defintion of \"Accessibility\" on Apple's accessibility page (https://www.apple.com/accessibility/)")
            }
            
            Spacer().frame(height: 30)
            
            VStack(spacing: 15) {
                Text("Your eyes: more than a window to the world.")
                    .font(.title)
                
                Text("This app aims to use ARKit to explore the possibilities of gaze contorl: to allow the user to control the device with just their gaze.")
                
                Text("It should be noted that The concept of using gaze-based control does exist in at least two implementations across the Mac and iPad:")
                
                Text("On macOS, the \"head cursor\" feature can be used to control the cursor with the user's head movements. However, it's not a \"gaze control\" solution as it replies of movement of the head rather than the eyes (gaze). Source: https://support.apple.com/en-gb/guide/mac-help/mchlb2d4782b/mac")
                
                Text("On iPadOS, \"Dwell Control\" is a fully supported feature. However, it requires the use of a dedicated eye-tracking device and cannot currently use any of the iPad's built-it sensors. Source: https://support.apple.com/guide/ipad/eye-tracking-device-ipad2cd35723/ipados")
            }
            
            Spacer().frame(height: 10)
            
            VStack(spacing: 15) {
                Text("Therefore, the objective of this app is to attempt to demonstrate what degree of gaze control is possible")
                
                Text("This app is inspired in part by the research done by Martez E. Mott, Shane Williams, Jacob O. Wobbrock, Meredith Ringel Morris, titled \"Improving Dwell-Based Gaze Typing with Dynamic, Cascading Dwell Times\" and published under the University of Washington's Information School and Microsoft Research. Source: https://www.microsoft.com/en-us/research/publication/improving-dwell-based-gaze-typing-dynamic-cascading-dwell-times/")
                
                NavigationLink(destination: DemoListView()) {
                    Text("-> Let's see what we can do with our gaze! ->")
                }
                .disabled(nextButtonDisabled)
            }
        }
        .padding(30)
        .onAppear() {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                nextButtonDisabled = false
            }
        }
    }
}
