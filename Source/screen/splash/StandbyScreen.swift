//
//  StandbyScreen.swift
//  Health_Weight
//
//  Created by Boss on 09/06/2025.
//

import SwiftUI
import Lottie

struct StandbyScreen: View {
    @EnvironmentObject var route: Router
    @State private var isShowtext = 0.0
    @State private var isTextVisible = false
    
    var body: some View {
        VStack {
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
                withAnimation(.easeInOut(duration: 2)) {
                    isShowtext = 0.9
                }
            }
            
            Spacer()
            
            LottieView(animation: .named("anim_loading.json")).playbackMode(.playing(.toProgress(1, loopMode: .loop))).frame(height: 96)
            
            VStack {
                Text("This action may contain mds... ")
                    .font(.system(size: 12))
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .onAppear {
            animateTextAndNavigate()
        }
    }
    
    private func animateTextAndNavigate() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            withAnimation(.easeIn(duration: 1)) {
                isTextVisible = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                let isFirstLaunch = UserDefaults.standard.bool(forKey: KEY_FIRST_APP)
                if isFirstLaunch {
                    self.route.navigateTo(.onboard)
                }
            }
        }
    }
}

#Preview {
    StandbyScreen()
}
