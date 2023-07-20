// reference: https://github.com/ukitomato/EyeTrackKit/blob/master/Sources/EyeTrackKit/Model/Device.swift

import SwiftUI

// A utility struct to get the screen size and ranges of a specific device.

struct Device {
    static var screenSize: CGSize {
        let screenWidthPixel: CGFloat = UIScreen.main.nativeBounds.width
        let screenHeightPixel: CGFloat = UIScreen.main.nativeBounds.height
    
        return CGSize(width: (screenWidthPixel / UIScreen.main.scale * 264) / 22.91309857, height: (screenHeightPixel / UIScreen.main.scale * 264) / 5.23100994)
    }
    
    static var frameSize: CGSize {
        return CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height - 40) // status bar height: 40 points
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
