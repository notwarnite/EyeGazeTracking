import SwiftUI
import ARKit
import RealityKit

struct CustomARViewContainer: UIViewRepresentable {
    @Binding var lookAtPoint: CGPoint?
    @Binding var isEyeTrackingStarted: Bool
    
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        arView.session.delegate = context.coordinator
        let configuration = ARFaceTrackingConfiguration()
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        if isEyeTrackingStarted {
            let configuration = ARFaceTrackingConfiguration()
            uiView.session.run(configuration)
        } else {
            uiView.session.pause()
        }
    }
    
    func makeCoordinator() -> ARCoordinator {
        ARCoordinator(lookAtPoint: $lookAtPoint)
    }
}
