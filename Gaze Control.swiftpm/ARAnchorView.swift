//
//  ARAnchorView.swift
//  Gaze Control
//
//  Created by Lucas Wang on 4/14/22.
//

import SwiftUI
import SceneKit
import ARKit

struct ARAnchorTest: UIViewRepresentable {
    
    // (x, y, z) of where the eyes are looking at
    @Binding var gazeX: Float
    @Binding var gazeY: Float
    @Binding var gazeZ: Float
    
    // Facial characteristics
    @Binding var eyeBlinkRight: Float
    @Binding var eyeBlinkLeft: Float
    @Binding var tongueOut: Float
        
    func makeUIView(context: Context) -> ARSCNView {
        let view = ARSCNView()
        view.delegate = context.coordinator
        view.session.delegate = context.coordinator
        view.automaticallyUpdatesLighting = true
        
        /// - Tag: ARFaceTrackingSetup
        func resetTracking() {
            guard ARFaceTrackingConfiguration.isSupported else { return }
            let configuration = ARFaceTrackingConfiguration()
            if #available(iOS 13.0, *) {
                configuration.maximumNumberOfTrackedFaces = ARFaceTrackingConfiguration.supportedNumberOfTrackedFaces
            }
            configuration.isLightEstimationEnabled = true
            view.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
        }
        
        resetTracking()
        
        return view
    }
    
    func updateUIView(_ uiView: ARSCNView, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(coordinated: self)
    }
    
    class Coordinator: NSObject, ARSCNViewDelegate, ARSessionDelegate {
        let coordinated: ARAnchorTest
        init(coordinated: ARAnchorTest) {
            self.coordinated = coordinated
        }
        
        var contentNode: SCNNode?
        lazy var rightEyeNode = SCNReferenceNode(named: "coordinateOrigin")
        lazy var leftEyeNode = SCNReferenceNode(named: "coordinateOrigin")
        
        func session(_ session: ARSession, didFailWithError error: Error) {
            guard error is ARError else { return }
            
            let errorWithInfo = error as NSError
            let messages = [
                errorWithInfo.localizedDescription,
                errorWithInfo.localizedFailureReason,
                errorWithInfo.localizedRecoverySuggestion
            ]
            let errorMessage = messages.compactMap({ $0 }).joined(separator: "\n")
            
            print(errorMessage)
        }
        
        func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
            // This class adds AR content only for face anchors.
            guard anchor is ARFaceAnchor else { return nil }
            
            // Load an asset from the app bundle to provide visual content for the anchor.
            contentNode = SCNReferenceNode(named: "coordinateOrigin")
            
            // Add content for eye tracking in iOS 12.
            self.addEyeTransformNodes()
            
            // Provide the node to ARKit for keeping in sync with the face anchor.
            return contentNode
        }
        
        func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
            guard #available(iOS 12.0, *), let faceAnchor = anchor as? ARFaceAnchor
                else { return }
            
            rightEyeNode.simdTransform = faceAnchor.rightEyeTransform
            leftEyeNode.simdTransform = faceAnchor.leftEyeTransform
            
            coordinated.gazeX = faceAnchor.lookAtPoint.x
            coordinated.gazeY = faceAnchor.lookAtPoint.y
            coordinated.gazeZ = faceAnchor.lookAtPoint.z
            
            coordinated.eyeBlinkRight = faceAnchor.blendShapes[.eyeBlinkRight]?.floatValue ?? 0.0
            coordinated.eyeBlinkLeft = faceAnchor.blendShapes[.eyeBlinkLeft]?.floatValue ?? 0.0
            coordinated.tongueOut = faceAnchor.blendShapes[.tongueOut]?.floatValue ?? 0.0
        }
        
        func addEyeTransformNodes() {
            guard let anchorNode = contentNode else { return }
            
            // Scale down the coordinate axis visualizations for eyes.
            rightEyeNode.simdPivot = float4x4(diagonal: [3, 3, 3, 1])
            leftEyeNode.simdPivot = float4x4(diagonal: [3, 3, 3, 1])
            
            anchorNode.addChildNode(rightEyeNode)
            anchorNode.addChildNode(leftEyeNode)
        }
    }
}

extension SCNReferenceNode {
    convenience init(named resourceName: String, loadImmediately: Bool = true) {
        let url = Bundle.main.url(forResource: resourceName, withExtension: "scn", subdirectory: "Models.scnassets")!
        self.init(url: url)!
        if loadImmediately {
            self.load()
        }
    }
}

extension Float {
     var toString: String {
         get { String(self) }
         set { self = Float(newValue)! }
     }
 }
