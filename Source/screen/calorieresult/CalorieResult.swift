//
//  CalorieResult.swift
//  Health_Weight
//
//  Created by Boss on 19/06/2025.
//

import SwiftUI

struct CalorieResult: View {
    @EnvironmentObject var route: Router
    let bmr: Double
    let tdee: Double
    let unit: String
    @State private var animatedBMR: Int = 0
    @State private var animatedTDEE: Int = 0
    @State private var timer: Timer?
    var body: some View {
        let formatUnit = unit == "Kilojoules" ? "kJ/day" : "Calorie/day"
        let maintain = tdee
        let mildLoss = tdee - 200
        let loss = tdee - 500
        let extremeLoss = tdee - 800
        let mildGain = tdee + 250
        let gain = tdee + 500
        let extremeGain = tdee + 1000
        
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
            
            ScrollView {
                VStack(spacing: 15) {
                    Text(localizedkey: "abc_textresult")
                        .font(.system(size: 15))
                        .padding(.top, 10)
                    
                    calorieRow(titleKey: "abc_maintain", offset: 0, color: .blue.opacity(0.7))
                    calorieRow(titleKey: "abc_maid", offset: -200, color: .orange.opacity(0.7))
                    calorieRow(titleKey: "abc_weightLoss", offset: -500, color: .orange.opacity(0.4))
                    calorieRow(titleKey: "abc_extrame", offset: -800, color: .pink.opacity(0.6))
                    
                    Text(localizedkey: "abc_textn")
                        .font(.system(size: 15))
                        .padding(.top, 10)
                    
                    calorieRow(titleKey: "abc_midweightcan", offset: 250, color: .yellow.opacity(0.6))
                    calorieRow(titleKey: "abc_weightGain", offset: 500, color: .red.opacity(0.6))
                    calorieRow(titleKey: "abc_extremeWeightgain", offset: 1000, color: .pink.opacity(0.6))
                }
                .padding()
            }
            
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
            Spacer()
        }
        .onAppear {
            startAnimation()
        }
        .onDisappear {
            timer?.invalidate()
        }
    }
    
    func startAnimation() {
        let duration: Double = 1.5 // giây
        let stepTime: Double = 0.02 // mỗi bước 20ms
        let totalSteps = Int(duration / stepTime)
        
        var currentStep = 0
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: stepTime, repeats: true) { timer in
            if currentStep >= totalSteps {
                animatedBMR = Int(bmr)
                animatedTDEE = Int(tdee)
                timer.invalidate()
            } else {
                let progress = Double(currentStep) / Double(totalSteps)
                animatedBMR = Int(Double(bmr) * progress)
                animatedTDEE = Int(Double(tdee) * progress)
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
                Text(String(format: "%.1f", max(Double(animatedTDEE) + offset, 0)))
                    .font(.system(size: 20))
                    .bold()
                    .animation(.easeOut(duration: 0.2), value: animatedTDEE)
                
                Text(unit == "Kilojoules" ? "Kilojoules/ day" : "Calorie/ day")
                    .font(.system(size: 14))
                    .frame(width: 120)
            }
        }
    }
}



