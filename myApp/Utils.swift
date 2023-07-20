// reference: https://github.com/ukitomato/EyeTrackKit/blob/master/Sources/EyeTrackKit/Model/Device.swift

import SwiftUI

// A utility struct to get the screen size and ranges of a specific device.

struct Device {
    static var screenSize: CGSize {
        let screenWidthPixel: CGFloat = UIScreen.main.nativeBounds.width
        let screenHeightPixel: CGFloat = UIScreen.main.nativeBounds.height
        
        let ppi: CGFloat = UIScreen.main.scale * 264 // iPad Pro 11-inch PPI value: 264 
        
        let a_ratio = (2388 / 1668) / 0.0623908297
        let b_ratio = (1688 / 2388) / 0.135096943231532
        
        return CGSize(width: (screenWidthPixel / ppi) / a_ratio, height: (screenHeightPixel / ppi) / b_ratio)
    }
    
    static var frameSize: CGSize {  // iPad Pro 11-inch 834, 1194
        return CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height - 40)
    }
}

struct Ranges {
    static let widthRange: ClosedRange<CGFloat> = (0...Device.frameSize.width)
    static let heightRange: ClosedRange<CGFloat> = (0...Device.frameSize.height)
}

extension CGFloat {
    func clamped(to: ClosedRange<CGFloat>) -> CGFloat {
        return to.lowerBound > self ? to.lowerBound
        : to.upperBound < self ? to.upperBound
        : self
    }
}
