// reference: https://developer.apple.com/documentation/arkit/arfaceanchor/2968192-lookatpoint

import SwiftUI
import ARKit

class ARCoordinator: NSObject, ARSessionDelegate {
    @Binding var lookAtPoint: CGPoint?

    // Keeps track of recent focus points for calculating sliding average for smoother translation
    private var gazeCoordinatesBuffer: [CGPoint] = []
    private let windowSize = 4
    
    init(lookAtPoint: Binding<CGPoint?>) {
        _lookAtPoint = lookAtPoint
        super.init()
    }
    
    func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {
        guard let faceAnchor = anchors.compactMap({ $0 as? ARFaceAnchor }).first else { return }
        
        let lookAtPoint = faceAnchor.lookAtPoint
        guard let cameraTransform = session.currentFrame?.camera.transform else { return }
        
        // Transforms the lookAtPoint from face anchor's local coordinate space to world coordinate space.
        let lookAtPointInWorld = faceAnchor.transform * simd_float4(lookAtPoint, 1)
        let transformedLookAtPoint = simd_mul(simd_inverse(cameraTransform), lookAtPointInWorld)
        
        let screenXPosition = transformedLookAtPoint.y / (Float(Device.screenSize.width) / 2) * Float(Device.frameSize.width)
        let screenYPosition = transformedLookAtPoint.x / (Float(Device.screenSize.height) / 2) * Float(Device.frameSize.height)
        
        // Clamps the screen coordinates to predefined ranges to prevent out-of-bounds values. (so circle doesn't go out of frame)
        let clampedX = CGFloat(screenXPosition).clamped(to: Ranges.widthRange)
        let clampedY = CGFloat(screenYPosition).clamped(to: Ranges.heightRange)
        
        let focusPoint = CGPoint(x: clampedX, y: clampedY)
        
        // calculations for sliding average of eye gaze points
        gazeCoordinatesBuffer.append(focusPoint)
        
        if gazeCoordinatesBuffer.count > windowSize {
            gazeCoordinatesBuffer.removeFirst()
        }
        
        let averageX = gazeCoordinatesBuffer.reduce(0) {$0 + $1.x} / CGFloat(gazeCoordinatesBuffer.count)
        
        let averageY = gazeCoordinatesBuffer.reduce(0) {$0 + $1.y} / CGFloat(gazeCoordinatesBuffer.count)
        
        let smoothFocusPoint = CGPoint(x: averageX, y: averageY)
        
        DispatchQueue.main.async {
            self.lookAtPoint = smoothFocusPoint
        }
    }
}
