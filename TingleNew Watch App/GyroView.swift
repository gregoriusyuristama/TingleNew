//
//  GyroView.swift
//  Tingle Watch App
//
//  Created by Azella Mutyara on 24/08/23.
//

import SwiftUI
import CoreMotion

struct GyroView: View {
    @State private var tiltAngle: Double = 0
    private let motionManager = CMMotionManager()
    @State private var accData: Double = 0
    //    @State private var ballPosition: CGSize = .zero
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Image("Ball")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .position(calculateCirclePosition(in: geo.size))
                    .offset(y: 35)
                Seesaw(angle: tiltAngle)
            }
            .onAppear {
                if motionManager.isAccelerometerAvailable {
                    motionManager.accelerometerUpdateInterval = 0.1
                    motionManager.startAccelerometerUpdates(to: OperationQueue.main) { (data, error) in
                        if let acceleration = data?.acceleration {
                            withAnimation {
                                let xAcceleration = acceleration.x
                                self.accData = xAcceleration
                                let tiltAngle = atan(xAcceleration) * 180 / .pi
                                self.tiltAngle = tiltAngle
                            }
                        }
                    }
                }
            }
            .onDisappear {
                motionManager.stopAccelerometerUpdates()
            }
        }
        
        
        
    }
    private func calculateCirclePosition(in size: CGSize) -> CGPoint {
        let centerX = size.width / 2
        let centerY = size.height / 2
        let radiusY = centerY - 10// Radius of the circle
        let radiusX = centerX - 10 // Radius of the circle
        
        let circleX = centerX + radiusX * CGFloat(sin(tiltAngle * .pi / 180))
        var circleY = 0.0
        if accData > -0.2 && accData < 0.2 {
            circleY = centerY - radiusY * CGFloat(cos(tiltAngle * .pi / 180))
        }else if abs(accData) >= 0.68{
            circleY = radiusY * CGFloat(cos(tiltAngle  * .pi / 180) * abs(accData))
        } else {
            circleY = radiusY * CGFloat(cos(tiltAngle  * .pi / 180) * abs(accData * 0.8))
        }
        
        return CGPoint(x: circleX, y: circleY)
    }
}

struct GyroView_Previews: PreviewProvider {
    static var previews: some View {
        GyroView()
    }
}
