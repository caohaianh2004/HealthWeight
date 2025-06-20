//
//  Results.swift
//  Health_Weight
//
//  Created by Boss on 20/06/2025.
//

import SwiftUI

struct Results: View {
    @EnvironmentObject var route: Router
    let bmr: Double
    let unit: String
    let tdee: Double
    @State private var animatedBMR: Int = 0
    @State private var timer: Timer?
    
    var body: some View {
        let formatUnit = unit == "Kilojoules" ? "kJ/day" : "Calorie/day"
        let maintain = tdee
        let mildLoss = tdee - 200
        
        VStack {
            HStack {
                Button {
                    route.navigateBack()
                } label: {
                    Image(systemName: "arrow.backward")
                        .font(.title)
                        .foregroundColor(.black)
                }
                .padding()
                Spacer()
                
                Text(localizedkey: "abc_calorie")
                    .font(.title2)
                    .bold()
                    .frame(maxWidth: .infinity)
                    .padding(.leading, -54)
                
                Spacer()
            }
            Text(localizedkey: "abc_textresult")
                .font(.system(size: 15))
                .padding(5)
            
            calorieRow(titleKey: "abc_maintain", offset: 0, color: .blue.opacity(0.7))
            
            Spacer()
            
            HStack {
                Button {
                    route.navigateBack()
                } label: {
                    Text(localizedkey: "abc_tryAgain")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .foregroundStyle(.white)
                        .cornerRadius(10)
                        .bold()
                }
                
                Button {
                    route.navigateTo(.home)
                } label: {
                    Text(localizedkey: "abc_home")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .foregroundStyle(.black)
                        .cornerRadius(10)
                        .bold()
                }
            }
            .padding()
        }
        .onAppear {
            startAnimation()
        }
        .onDisappear {
            timer?.invalidate()
        }

        
        Spacer()
        
    }
    
    func startAnimation() {
        let duration: Double = 1.5
        let stepTime: Double = 0.02
        let totalSteps = Int(duration / stepTime)
        var currentStep = 0

        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: stepTime, repeats: true) { timer in
            if currentStep >= totalSteps {
                animatedBMR = Int(bmr)
                timer.invalidate()
            } else {
                let progress = Double(currentStep) / Double(totalSteps)
                animatedBMR = Int(bmr * progress)
                currentStep += 1
            }
        }
    }

    
    @ViewBuilder
    func calorieRow(titleKey: String, offset: Double, color: Color) -> some View {
        HStack {
            Text(localizedkey: titleKey)
                .frame(width: 200, height: 45)
                .padding()
                .multilineTextAlignment(.center)
                .background(color)
                .cornerRadius(10)
                .font(.system(size: 15))
                .frame(maxWidth: .infinity)
            
            VStack {
                Text(String(format: "%.1f", max(Double(animatedBMR) + offset, 0)))
                    .font(.system(size: 20))
                    .bold()
                    .animation(.easeOut(duration: 0.2), value: animatedBMR)
                
                Text(unit == "Kilojoules" ? "Kilojoules/ day" : "Calorie/ day")
                    .font(.system(size: 14))
                    .frame(width: 120)
            }
        }
    }
}

//#Preview {
//    Results()
//}
