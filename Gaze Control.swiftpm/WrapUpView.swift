//
//  File.swift
//  Gaze Control
//
//  Created by Lucas Wang on 4/24/22.
//

import SwiftUI

struct WrapUpView: View {
    var body: some View {
        VStack(spacing: 5) {
            Text("Let's recap what accessibility is!")
                .font(.title)
            
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
            
            Text("Throughout the development of Gaze Control, I've learned much more about ARKit and ARFaceAnchor than I had expected. And even with my relatively rough implemetation of calibration, the App is still quite functional.")
            
            Text("In the future, I plan on extending the functionality of the app to more than just being able to tap four corners, and to investigate how to tweak the calibration and sensing process to increase the precision of gaze tracking!")
        }
        .padding(30)
    }
}
