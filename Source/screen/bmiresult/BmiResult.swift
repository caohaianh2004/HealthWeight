//
//  BmiResult.swift
//  Health_Weight
//
//  Created by Boss on 11/06/2025.
//

import SwiftUI

struct BmiResult: View {
    @EnvironmentObject var route: Router
    @State private var aminatedBMI: Double = 0
    @State private var showResult = false
    let bmi: Double
    let healthyWeightRange: String
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    route.navigateBack()
                } label: {
                    Image(systemName: "arrow.left")
                        .foregroundColor(.black)
                        .font(.title)
                }
                Spacer()
                Text(localizedkey: "abc_result")
                    .font(.title2)
                    .bold()
                    .frame(maxWidth: .infinity)
                    .padding(.leading, -40)
                
                Button {
                    
                } label: {
                    Image("information")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30)
                }
            }
            .padding()
            
            ScrollView {
              ControlNeedle()
                    .padding()
                
                if showResult {
                    Text(String(format: "BMI = %.1f kg/m2", bmi))
                        .bold()
                    let status = bmiStatus()
                    Text("(\(status.text))")
                        .font(.headline)
                        .foregroundColor(status.color)
                }
                
              Text(localizedkey: "abc_bmiResult")
                   
              Text(healthyWeightRange)
                    .font(.system(size: 15))
                    .bold()
                
              Text(localizedkey: "abc_textbmi")
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.center)
                    .padding(5)
                
                Image("Image8")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300)
                    .padding()
            }
            Buttontoobal()
        }
        .onAppear {
            withAnimation(.easeOut(duration: 2.5)) {
            aminatedBMI = bmi
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.3) {
             showResult = true
            }
        }
        
    }
    
    func ControlNeedle() -> some View {
        let angle = Angle(degrees: mapBMIToAngle(bmi: aminatedBMI))
        
        return ZStack {
                Image("control")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300)
                
                Image("needle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30)
                    .rotationEffect(angle, anchor: .bottom)
                    .padding(.top, 20)
                    .offset(y: -10)
            }
    }
    
    func mapBMIToAngle(bmi: Double) -> Double {
        let clampedBMI = max(min(bmi, 40), 10) // Giới hạn BMI từ 10 đến 40
        let progress = (clampedBMI - 10) / 30  // Tiến trình từ 0.0 → 1.0
        return progress * 180 - 90             // Map thành -90° → 90°
    }

    
    @ViewBuilder
    func Buttontoobal() -> some View {
        HStack {
            Button {
                route.navigateBack()
            } label: {
                Text(localizedkey: "abc_tryAgain")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .cornerRadius(15)
                    .font(.system(size: 18))
                    .foregroundColor(.white)
                    .bold()
            }
            
            Button {
                route.navigateTo(.home)
            } label: {
                Text(localizedkey: "abc_home")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.gray.opacity(0.4))
                    .cornerRadius(15)
                    .font(.system(size: 18))
                    .foregroundColor(.black)
                    .bold()
            }

        }
        .padding()
    }
    
    @ViewBuilder
    func bmiStatus() -> (text: String, color: Color) {
        switch bmi {
        case ..<16.0:
            return("Severe Thinness", .blue)
        case 16.1..<17.0:
            return("Moderate Thinness", .blue.opacity(0.5))
        case 17.1..<18.4:
            return("Overweight", .blue.opacity(0.3))
        case 18.5..<25.1:
            return("Normal", .green)
        case 25.2..<30.0:
            return("Overweight", .yellow)
        case 30.1..<34.9:
            return("Obese I", .orange)
        case 35.0..<39.9:
            return("Obese II", .red.opacity(0.7))
        default:
            return ("Obese III", .red)
        }
    }
}

//#Preview {
//    BmiResult(bmi: 1.0, healthyWeightRange: "39.2kg - 66.4kg")
//}

