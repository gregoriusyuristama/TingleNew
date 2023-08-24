//
//  SeeSaw.swift
//  Tingle Watch App
//
//  Created by Gregorius Yuristama Nugraha on 8/24/23.
//

import SwiftUI

struct Seesaw: View {
    var angle: Double
    
    var body: some View {
        VStack {
            Image("Seesaw")
                .resizable()
                .frame(width: 130, height: 10)
                .cornerRadius(1)
                .rotationEffect(.degrees(angle), anchor: .center)
                .zIndex(0)
            
            Image("Tumpuan")
                .resizable()
                .frame(width: 23, height: 35)
                .offset(y: -15)
                .zIndex(1)
        }
    }
}


struct SeeSaw_Previews: PreviewProvider {
    static var previews: some View {
        Seesaw(angle: 0)
    }
}
