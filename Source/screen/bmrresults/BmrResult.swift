//
//  BmrResult.swift
//  Health_Weight
//
//  Created by Boss on 20/06/2025.
//

import SwiftUI

struct BmrResult: View {
    @EnvironmentObject var route: Router
    let bmr: Double
    let tdee: Double
    let unit: String
    @State private var animatedBMR: Int = 0
    @State private var animatedTDEE: Int = 0
    @State private var timer: Timer?
    @State private var animatedTDEEs: [Double] = Array(repeating: 0.0, count: 6)

        
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
            toobal()
            
            ScrollView {
                Image("Image9")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300)
                
                bmrResult()
            }
            
            buttonBmr()
            Spacer()
        }
        .onAppear {
            startAnimation()
        }
        .onDisappear {
            timer?.invalidate()
        }
    }
    
    func toobal() -> some View {
        HStack {
            Button {
                route.navigateBack()
            } label: {
                Image(systemName: "arrow.left")
                    .font(.title)
                    .foregroundColor(.black)
            }
            Spacer()
            
            Text(localizedkey: "abc_bmrresult")
                .foregroundStyle(Color.black)
                .font(.title2)
                .frame(maxWidth: .infinity)
                .bold()
                .padding(.leading, -42)
        }
        .padding()
    }
    
    func bmrResult() -> some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(String(format: "BMR: %.1f %@", Double(animatedBMR), unit == "Kilojoules" ? "Kj/day" : "Calo/day"))
                .font(.title2)
                .bold()
                .frame(maxWidth: .infinity, alignment: .center)

            Text(localizedkey: "abc_textbmr")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 16))
                .padding(.horizontal)

            Group {
                HStack {
                    Text("Activity Level")
                        .bold()
                        .padding(.vertical, 8)
                        .padding(.horizontal)
                        .background(Color.green)
                        .cornerRadius(10)
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    Text(unit == "Kilojoules" ? "Kilojoule" : "Calorie")
                        .bold()
                        .padding(.vertical, 8)
                        .padding(.horizontal)
                        .background(Color.green)
                        .cornerRadius(10)
                        .foregroundColor(.white)
                }
                activityRow(label: "Sedentary: little or no exercise", index: 0)
                activityRow(label: "Exercise 1-3 times/week", index: 1)
                activityRow(label: "Exercise 4-5 times/week", index: 2)
                activityRow(label: "Daily or intense 3-4 times/week", index: 3)
                activityRow(label: "Intense exercise 6-7 times/week", index: 4)
                activityRow(label: "Very intense daily or physical job", index: 5)

            }
            .padding(.horizontal)
            
            VStack {
                HStack {
                    Text(localizedkey: "abc_textexercise")
                        .font(.system(size: 12))
                        .bold()
                    Text(localizedkey: "abc_exercise")
                        .font(.system(size: 12))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                HStack {
                    Text(localizedkey: "abc_textIntense")
                        .font(.system(size: 12))
                        .bold()
                    Text(localizedkey: "abc_Intense")
                        .font(.system(size: 12))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                HStack {
                    Text(localizedkey: "abc_very")
                        .font(.system(size: 12))
                        .bold()
                    Text(localizedkey: "abc_verintense")
                        .font(.system(size: 12))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(2)
        }
    }
    
    
    func buttonBmr() -> some View {
        HStack {
            Button {
                route.navigateBack()
            } label: {
                Text(localizedkey: "abc_tryAgain")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .foregroundStyle(Color.white)
                    .bold()
                    .background(Color.green)
                    .cornerRadius(13)
            }
           
            Button {
                route.navigateTo(.home)
            } label: {
                Text(localizedkey: "abc_home")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.black)
                    .bold()
                    .background(Color.gray)
                    .cornerRadius(13)
            }
        }
        .padding(10)
    }
    
    
    func startAnimation() {
        let duration: Double = 1.5 // giây
        let stepTime: Double = 0.02
        let totalSteps = Int(duration / stepTime)

        let factors: [Double] = [1.2, 1.375, 1.55, 1.725, 1.9, 2.0]
        var currentStep = 0
        timer?.invalidate()

        timer = Timer.scheduledTimer(withTimeInterval: stepTime, repeats: true) { timer in
            if currentStep >= totalSteps {
                animatedBMR = Int(bmr)
                animatedTDEE = Int(tdee)
                for i in 0..<factors.count {
                    animatedTDEEs[i] = bmr * factors[i]
                }
                timer.invalidate()
            } else {
                let progress = Double(currentStep) / Double(totalSteps)
                animatedBMR = Int(bmr * progress)
                animatedTDEE = Int(tdee * progress)
                for i in 0..<factors.count {
                    animatedTDEEs[i] = bmr * factors[i] * progress
                }
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
    
    @ViewBuilder
    func activityRow(label: String, index: Int) -> some View {
        let value = animatedTDEEs[index]
        HStack {
            Text(label)
                .font(.system(size: 14))
                .frame(maxWidth: .infinity, alignment: .leading)

            Text(String(format: "%.1f", animatedTDEEs[index]))
                .bold()
                .frame(width: 100, alignment: .trailing)
                .foregroundColor(.black)
                .animation(.easeOut(duration: 0.2), value: value)
        }
        .padding()
        .background(Color.gray.opacity(0.15))
        .cornerRadius(12)
    }

}

//#Preview {
//    BmrResult()
//}
