//
//  FourSquareGaze.swift
//  Gaze Control
//
//  Created by Lucas Wang on 4/23/22.
//

import SwiftUI

struct FourSquareGazeView: View {
    @State var instuctionAlertIsActive: Bool = false
    
    @State var gazeX: Float = 0
    @State var gazeY: Float = 0
    @State var gazeZ: Float = 0
    @State var topViewSize: CGSize = UIScreen.main.bounds.size
    
    @State var eyeBlinkRight: Float = 0
    @State var eyeBlinkLeft: Float = 0
    @State var tongueOut: Float = 0
        
    @State var topLeftIsDepressed: Bool = false
    @State var topRightIsDepressed: Bool = false
    @State var bottomLeftIsDepressed: Bool = false
    @State var bottomRightIsDepressed: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: topLeftIsDepressed ? "eyebrow" : "eyes")
                    .foregroundColor(topLeftIsDepressed ? .primary : .pink)
                    .font(.system(size: 169))
                    
                Spacer()
                
                Image(systemName: topRightIsDepressed ? "eyebrow" : "eyes")
                    .foregroundColor(topRightIsDepressed ? .primary : .pink)
                    .font(.system(size: 169))
            }
            
            Spacer()
            
            Text("With your eyes squarely on each of the four buttom, blink both eyes OR stick your tongue out to press it!")
            
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
                Image(systemName: bottomLeftIsDepressed ? "eyebrow" : "eyes")
                    .foregroundColor(bottomLeftIsDepressed ? .primary : .pink)
                    .font(.system(size: 169))
                
                Spacer()
                
                Image(systemName: bottomRightIsDepressed ? "eyebrow" : "eyes")
                    .foregroundColor(bottomRightIsDepressed ? .primary : .pink)
                    .font(.system(size: 169))
            }
        }
        .background() {
            GeometryReader { geo in
                Color.clear.onChange(of: geo.size) { newValue in
                    topViewSize = newValue
                }
            }
        }
        .onAppear() {
            instuctionAlertIsActive = true
        }
        .alert("Now, let's give gaze control a try! With your eyes squarely on each of the four buttom, blink both eyes OR stick your tongue out to press it!", isPresented: $instuctionAlertIsActive, actions: {
            Button("Got it!", role: .cancel) { }
        })
        .onChange(of: eyeBlinkLeft) { newEyeBlinkLeft in
            if newEyeBlinkLeft > 0.8 && eyeBlinkRight > 0.8 {
                addressTap()
            }
        }
        .onChange(of: tongueOut) { newTongueOut in
            if newTongueOut > 0.8 {
                addressTap()
            }
        }
    }
    
    func addressTap() {
        print("Tapped with gazeX = \(gazeX), gazeY = \(gazeY)")
        
        // If looking on the left side
        if gazeX > globalDataInstance.midVerticalX {
            // If looking at top left
            if gazeY < globalDataInstance.midHorizontalY {
                topLeftIsDepressed = true
            } else { // if looking at bottom left
                bottomLeftIsDepressed = true
            }
        } else { // if looking on the right side
            // If looking at the top right
            if gazeY < globalDataInstance.midHorizontalY {
                topRightIsDepressed = true
            } else { // If looking on the bottom right
                bottomRightIsDepressed = true
            }
        }
    }
}
