//
//  CrownView.swift
//  Tingle Watch App
//
//  Created by Azella Mutyara on 24/08/23.
//

import SwiftUI

struct CrownView: View {
    @State var scrollAmount = 0.0
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                VStack {
                    Spacer()
                    Image("windmill_stick")
                        .resizable()
                        .scaledToFit()
                        .frame(height: geo.size.height * 0.5)
                }
                
                VStack {
                    HStack {
                        Spacer()
                        Image("windmill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: geo.size.width * 0.80)
                            .cornerRadius(16)
                            .focusable(true)
                            .rotationEffect(Angle(degrees: scrollAmount))
                            .digitalCrownRotation($scrollAmount, from: 1, through: 360, by: 15.0, sensitivity: .high, isContinuous: true, isHapticFeedbackEnabled: true)
                        Spacer()
                    }
                    .padding(.top, 25)
                    Spacer()
                }
            }
        }
        .ignoresSafeArea()
    }
}

struct CrownView_Previews: PreviewProvider {
    static var previews: some View {
        CrownView()
    }
}
