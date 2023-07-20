import SwiftUI

struct ContentView: View {
    @State private var lookAtPoint: CGPoint?
    @State private var isEyeTrackingStarted = false
    
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
                
                Spacer()
            }
            
            if let position = lookAtPoint {
                Circle()
                    .fill(Color.blue)
                    .frame(width: 40, height: 40)
                    .position(x: position.x, y: position.y)
            }
        }
    }
    
    private func startEyeTracking() {
        isEyeTrackingStarted = true
    }
    
    private func stopEyeTracking() {
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
