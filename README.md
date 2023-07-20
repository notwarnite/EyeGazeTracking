# iOS EyeGazeTracking App

## Description

This repository contains the code for an iOS ARKit application that tracks eye gaze direction using the lookAtPoint property of ARFaceAnchor and converts the gaze vector into screen coordinates.

## Features

- Real-time eye gaze tracking using ARKit.
- Conversion of gaze direction into screen coordinates.
- Smooth focus point stabilization.

## Usage

1. Clone the repository to your local machine.
2. Open the project in Xcode.
3. Build and run the app on your iOS device with AR capabilities (e.g., iPad Pro 11-inch).
4. Grant necessary permissions (camera access) when prompted.
5. Once the app launches, click on start button to track your eye gaze direction in real-time.
6. The gaze coordinates will be converted to screen coordinates and displayed on the screen along with a circle to follow the eyegaze.

## Compatibility
Compatible on iOS devices that support ARKit.
- iOS 13 or higher.

## Development Environment
- Xcode verion 12 or higher
- Language: Swift
- Libraries: SwiftUI and ARKit
