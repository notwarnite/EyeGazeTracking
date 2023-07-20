//  CustomARViewContainer.swift
//
//  Created by RITWIK SINGH


import SwiftUI
import ARKit
import RealityKit

struct CustomARViewContainer: UIViewRepresentable {
    @Binding var lookAtPoint: CGPoint?
    @Binding var isEyeTrackingStarted: Bool
    
    // ARFaceTrackingConfiguration allows the app to track the user's face.
    private let configuration = ARFaceTrackingConfiguration()
    
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        arView.session.delegate = context.coordinator
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        if isEyeTrackingStarted {
            uiView.session.run(configuration)
        } else {
            uiView.session.pause()
        }
    }
    
    func makeCoordinator() -> ARCoordinator {
        ARCoordinator(lookAtPoint: $lookAtPoint)
    }
}