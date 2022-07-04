//
//  DemoListView.swift
//  Gaze Control
//
//  Created by Lucas Wang on 4/24/22.
//

import SwiftUI

struct DemoListView: View {
    @State var nextButtonCalibrationDisabled: Bool = true
    @State var nextButtonFourSquareDisabled: Bool = true
    @State var nextButtonDwellTimeAdjustmentDisabled: Bool = true
    @State var nextButtonWrapUpDisabled: Bool = true
    
    var body: some View {
        VStack(spacing: 20) {
            Text("So, what CAN we do with our gaze?")
                .font(.headline)
            
            Text("Each test will be gradually unlocked. Try them in order!")
            
            VStack {
                Text("#1 Calibration: We need to make sure the iPad knows what we're actually looking at!")
                    .foregroundColor(nextButtonCalibrationDisabled ? .gray : .primary)
                NavigationLink(destination: CalibrationView()) {
                    Label("Let's calibrate our gaze first!", systemImage: "hammer.fill")
                }
                .disabled(nextButtonCalibrationDisabled)
            }
            
            VStack {
                Text("#2 Gaze control with active input: Then, let's take our gaze out for a spin!")
                    .foregroundColor(nextButtonFourSquareDisabled ? .gray : .primary)
                NavigationLink(destination: FourSquareGazeView()) {
                    Label("Let's press some buttons with our face!", systemImage: "eyebrow")
                }
                .disabled(nextButtonFourSquareDisabled)
            }
            
            VStack {
                Text("#3 Gaze control with dwell delay: no blinking or tongue required!")
                    .foregroundColor(nextButtonFourSquareDisabled ? .gray : .primary)
                NavigationLink(destination: GazeDwellView()) {
                    Label("What if we don't want to blink or stick our tongue out?", systemImage: "eye")
                }
                .disabled(nextButtonDwellTimeAdjustmentDisabled)
            }
            
            VStack {
                Text("Wrap up!")
                    .foregroundColor(nextButtonFourSquareDisabled ? .gray : .primary)
                NavigationLink(destination: CalibrationView()) {
                    Label("So, what did we learn?", systemImage: "forward.end.alt.fill")
                }
                .disabled(nextButtonDwellTimeAdjustmentDisabled)
            }
        }
        .padding(30)
        .navigationTitle("The Possibilities of Gaze")
        .onAppear() {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                nextButtonCalibrationDisabled = false
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                nextButtonFourSquareDisabled = false
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                nextButtonDwellTimeAdjustmentDisabled = false
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                nextButtonWrapUpDisabled = false
            }
        }
    }
}
