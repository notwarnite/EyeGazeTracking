//  ContentView.swift
//
//  Created by RITWIK SINGH


import SwiftUI

struct ContentView: View {
    @State var lookAtPoint: CGPoint?
    @State var isEyeTrackingStarted = false
    
    var body: some View {
        ZStack {
            if isEyeTrackingStarted {
                CustomARViewContainer(lookAtPoint: $lookAtPoint, isEyeTrackingStarted: $isEyeTrackingStarted)
            }
            
            VStack {
                Spacer()
                
                Text("Gaze Coordinates:")
                
                if let position = lookAtPoint {
                    Text("\(Int(position.x)), \(Int(position.y))")
                        .padding()
                } else {
                    Text("Not tracking")
                        .padding()
                }
                
                Spacer()
                
                HStack(alignment: .center) {
                    Button(action: {
                        startEyeTracking()
                    }, label: {
                        Text("Start")
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.green)
                            .cornerRadius(10)
                    })
                    
                    Button(action: {
                        stopEyeTracking()
                    }, label: {
                        Text("Stop")
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.red)
                            .cornerRadius(10)
                    })
                }.padding()
            }
            
            if let position = lookAtPoint, position != .zero {
                Circle()
                    .fill(Color.blue)
                    .frame(width: 40, height: 40)
                    .position(x: position.x,
                              y: position.y)
            }
        }
    }
    
    
    func startEyeTracking() {
        isEyeTrackingStarted = true
    }
    
    func stopEyeTracking() {
        lookAtPoint = nil
        
        DispatchQueue.main.async {
            isEyeTrackingStarted = false
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}