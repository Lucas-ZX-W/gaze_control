//
//  File.swift
//  Gaze Control
//
//  Created by Lucas Wang on 4/24/22.
//

import SwiftUI

struct GazeDwellView: View {
    @State var instuctionAlertIsActive: Bool = false
    
    @State var dwellDelayThreshold: Float = 5
    
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
    
    // 0 = no quadrant
    // 1 = top left
    // 2 = top right
    // 3 = bottom left
    // 4 = bottom right
    @State var currentlyActiveQuadrant: Int = 0
    @State var currentGazeCounter: Int = 0
    
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
            
            Text("Stare at each buttom for a given amount of time to toggle them. Adjust the dwell time required for toggle with the slider below!")
            
            Slider(
                value: $dwellDelayThreshold,
                in: 3...8,
                step: 1
            )
            
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
        .onChange(of: gazeX) { newGazeX in
            // If looking on the left side
            if gazeX > globalDataInstance.midVerticalX {
                // If looking at top left
                if gazeY < globalDataInstance.midHorizontalY {
                    if currentlyActiveQuadrant == 1 {
                        if currentGazeCounter >= Int(dwellDelayThreshold * 5) {
                            topLeftIsDepressed.toggle()
                            currentGazeCounter = 0
                        } else {
                            currentGazeCounter += 1
                        }
                    } else {
                        currentlyActiveQuadrant = 1
                        currentGazeCounter = 0
                    }
                } else { // if looking at bottom left
                    if currentlyActiveQuadrant == 3 {
                        if currentGazeCounter >= Int(dwellDelayThreshold * 5) {
                            bottomLeftIsDepressed.toggle()
                            currentGazeCounter = 0
                        } else {
                            currentGazeCounter += 1
                        }
                    } else {
                        currentlyActiveQuadrant = 3
                        currentGazeCounter = 0
                    }
                }
            } else { // if looking on the right side
                // If looking at the top right
                if gazeY < globalDataInstance.midHorizontalY {
                    if currentlyActiveQuadrant == 2 {
                        if currentGazeCounter >= Int(dwellDelayThreshold * 5) {
                            topRightIsDepressed.toggle()
                            currentGazeCounter = 0
                        } else {
                            currentGazeCounter += 1
                        }
                    } else {
                        currentlyActiveQuadrant = 2
                        currentGazeCounter = 0
                    }
                } else { // If looking on the bottom right
                    if currentlyActiveQuadrant == 4 {
                        if currentGazeCounter >= Int(dwellDelayThreshold * 5) {
                            bottomRightIsDepressed.toggle()
                            currentGazeCounter = 0
                        } else {
                            currentGazeCounter += 1
                        }
                    } else {
                        currentlyActiveQuadrant = 4
                        currentGazeCounter = 0
                    }
                }
            }
        }
    }
}
