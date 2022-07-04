//
//  CalibrationView.swift
//  Gaze Control
//
//  Created by Lucas Wang on 4/24/22.
//

import SwiftUI

struct CalibrationView: View {
    @State var gazeX: Float = 0
    @State var gazeY: Float = 0
    @State var gazeZ: Float = 0
    @State var topViewSize: CGSize = UIScreen.main.bounds.size
    
    @State var eyeBlinkRight: Float = 0
    @State var eyeBlinkLeft: Float = 0
    @State var tongueOut: Float = 0
    
    @State var instructionAlertIsPresented: Bool = false
    @State var topLeftDidCalibrate: Bool = false
    @State var topRightDidCalibrate: Bool = false
    @State var bottomLeftDidCalibrate: Bool = false
    @State var bottomRightDidCalibrate: Bool = false
    
    @State var didCompleteCalibration: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    topLeftDidCalibrate = true
                    globalDataInstance.topLeftCornerPoint.x = gazeX
                    globalDataInstance.topLeftCornerPoint.y = gazeY
                    globalDataInstance.topLeftCornerPoint.z = gazeZ
                } label: {
                    Text("Look and tap to calibrate top left corner!")
                    Image(systemName: topLeftDidCalibrate ? "eyebrow" : "eyes")
                }
                .disabled(topLeftDidCalibrate)
                Spacer()
                Button {
                    topRightDidCalibrate = true
                    globalDataInstance.topRightCornerPoint.x = gazeX
                    globalDataInstance.topRightCornerPoint.y = gazeY
                    globalDataInstance.topRightCornerPoint.z = gazeZ
                } label: {
                    Text("Look and tap to calibrate top right corner!")
                    Image(systemName: topRightDidCalibrate ? "eyebrow" : "eyes")
                }
                .disabled(topRightDidCalibrate)
            }
            
            Spacer()
            
            Text("Try to hold the iPad AS STILL AS POSSIBLE and try to move only your eyes and NOT you head!")
            // MARK: eyeBlinkRight and eyeBlinkLeft is from the perspective of the device. To make things simpler for us, we swap it here when we're actually using ARAnchorView.
            ARAnchorTest(gazeX: $gazeX, gazeY: $gazeY, gazeZ: $gazeZ, eyeBlinkRight: $eyeBlinkLeft, eyeBlinkLeft: $eyeBlinkRight, tongueOut: $tongueOut)
                .frame(height: topViewSize.height / 2, alignment: .center)
                .onAppear {
                    UIApplication.shared.isIdleTimerDisabled = true
                }
                .onDisappear {
                    UIApplication.shared.isIdleTimerDisabled = false
                }
            
            Spacer()
            
            HStack {
                Button {
                    bottomLeftDidCalibrate = true
                    globalDataInstance.bottomLeftCornerPoint.x = gazeX
                    globalDataInstance.bottomLeftCornerPoint.y = gazeY
                    globalDataInstance.bottomLeftCornerPoint.z = gazeZ
                } label: {
                    Text("Look and tap to calibrate bottom left corner!")
                    Image(systemName: bottomLeftDidCalibrate ? "eyebrow" : "eyes")
                }
                .disabled(bottomLeftDidCalibrate)
                Spacer()
                Button {
                    bottomRightDidCalibrate = true
                    globalDataInstance.bottomRightCornerPoint.x = gazeX
                    globalDataInstance.bottomRightCornerPoint.y = gazeY
                    globalDataInstance.bottomRightCornerPoint.z = gazeZ
                } label: {
                    Text("Look and tap to calibrate bottom right corner!")
                    Image(systemName: bottomRightDidCalibrate ? "eyebrow" : "eyes")
                }
                .disabled(bottomRightDidCalibrate)
            }
        }
        .navigationTitle("Gaze Calibration")
        //.navigationBarBackButtonHidden(!didCompleteCalibration)
        .background() {
            GeometryReader { geo in
                Color.clear.onChange(of: geo.size) { newValue in
                    topViewSize = newValue
                }
            }
        }
        .onAppear() {
            instructionAlertIsPresented = true
        }
        .onDisappear() {
            print("Calibration complete")
            globalDataInstance.calculateBounds()
        }
        .alert("First, place your head centered-on with the iPad. For each of the four corners of the iPad, stare at the very edge of the corner and press the corresponding button to save the calibration value for that corner. Once all four corners are calibrated, the back button should be active, and you're feel to go back to explore more!", isPresented: $instructionAlertIsPresented, actions: {
            Button("Got it!", role: .cancel) { }
        })
//        .onChange(of: topLeftDidCalibrate) { newVal in
//            didCompleteCalibration = topLeftDidCalibrate && topRightDidCalibrate && bottomLeftDidCalibrate && bottomRightDidCalibrate
//        }
    }
}
