import ARKit

class ARCoordinator: NSObject, ARSessionDelegate {
    @Binding var lookAtPoint: CGPoint?
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
        
        let lookAtPointInWorld = faceAnchor.transform * simd_float4(lookAtPoint, 1)
        let transformedLookAtPoint = simd_mul(simd_inverse(cameraTransform), lookAtPointInWorld)
        
        let screenX = transformedLookAtPoint.y / (Float(Device.screenSize.width) / 2) * Float(Device.frameSize.width)
        let screenY = transformedLookAtPoint.x / (Float(Device.screenSize.height) / 2) * Float(Device.frameSize.height)
        
        let clampedX = CGFloat(screenX).clamped(to: Ranges.widthRange)
        let clampedY = CGFloat(screenY).clamped(to: Ranges.heightRange)
        
        let focusPoint = CGPoint(x: clampedX, y: clampedY)
        
        gazeCoordinatesBuffer.append(focusPoint)
        
        if gazeCoordinatesBuffer.count > windowSize {
            gazeCoordinatesBuffer.removeFirst()
        }
        
        let averageX = gazeCoordinatesBuffer.reduce(0) { $0 + $1.x } / CGFloat(gazeCoordinatesBuffer.count)
        let averageY = gazeCoordinatesBuffer.reduce(0) { $0 + $1.y } / CGFloat(gazeCoordinatesBuffer.count)
        
        let smoothFocusPoint = CGPoint(x: averageX, y: averageY)
        DispatchQueue.main.async {
            self.lookAtPoint = smoothFocusPoint
        }
    }
}
