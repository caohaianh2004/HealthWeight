//
//  StandbyScreen.swift
//  Health_Weight
//
//  Created by Boss on 09/06/2025.
//

import SwiftUI

struct StandbyScreen: View {
    @State private var isShowtext = 0.0
    var body: some View {
        VStack {
            Image("Image5")
                .resizable()
                .scaledToFit()
                .frame(width: 300)
            
            Text("Health Calc & Weight Tracker")
                .font(.title2)
                .bold()
                .opacity(isShowtext)
        }
        .frame(maxHeight: .infinity, alignment: .center)
        .onAppear {
            withAnimation(.easeInOut(duration: 8)) {
                isShowtext = 1.0
            }
        }
        
        Spacer()
        
        VStack {
            Text("This action may contain mds... ")
                .font(.system(size: 12))
        }
    }
}

#Preview {
    StandbyScreen()
}
