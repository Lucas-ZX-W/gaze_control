//
//  File.swift
//  Gaze Control
//
//  Created by Lucas Wang on 4/24/22.
//

import Foundation

class GlobalData: ObservableObject {
    @Published var topLeftCornerPoint: Point = Point(x: 0, y: 0, z: 0)
    @Published var topRightCornerPoint: Point = Point(x: 0, y: 0, z: 0)
    @Published var bottomLeftCornerPoint: Point = Point(x: 0, y: 0, z: 0)
    @Published var bottomRightCornerPoint: Point = Point(x: 0, y: 0, z: 0)
    
    @Published var topYBound: Float = 0
    @Published var bottomYBound: Float = 0
    @Published var leftXBound: Float = 0
    @Published var rightXBound: Float = 0
    
    // Main and cross axis
    @Published var midHorizontalY: Float = 0
    @Published var midVerticalX: Float = 0
    
    // 4-gaze specific
    @Published var topBottomSeperationBound: Float = 0
    
    
    @Published var calibratedOnce: Bool = false
    
    public func calculateBounds() {
        topYBound = (topLeftCornerPoint.y + topRightCornerPoint.y) / 2
        bottomYBound = (bottomLeftCornerPoint.y + bottomRightCornerPoint.y) / 2
        leftXBound = (topLeftCornerPoint.x + bottomLeftCornerPoint.x) / 2
        rightXBound = (topRightCornerPoint.x + bottomRightCornerPoint.x) / 2
        
        midHorizontalY = bottomYBound + ((abs(topYBound) + abs(bottomYBound)) / 2)
        midVerticalX = rightXBound + ((abs(leftXBound) + abs(rightXBound)) / 2)
        print("midHorizontalY = \(midHorizontalY.toString)")
        print("midVerticalX = \(midVerticalX.toString)")
        
        topBottomSeperationBound = bottomYBound + ((abs(topYBound) + abs(bottomYBound)) / 4)
        
        calibratedOnce = true
    }
}

struct Point {
    var x: Float
    var y: Float
    var z: Float
}

// Global object for keeping track of global changes
let globalDataInstance: GlobalData = GlobalData()
