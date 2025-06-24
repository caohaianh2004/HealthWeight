//
//  BodyFatResult.swift
//  Health_Weight
//
//  Created by Boss on 23/06/2025.
//

import SwiftUI

struct BodyFatResult: View {
    @EnvironmentObject var route: Router
    let bodyFatPercentage: Double
    let fatMass: Double
    let leanMass: Double
    let idealFatPercent: Double
    let fatToLose: Double
    let bmiMethodFat: Double
    let category: String
    let gender: String
    let unit: String
    @State private var animatedFat: Double = 0.0
    @State private var animatedFatMass: Double = 0.0
    @State private var animatedLeanMass: Double = 0.0
    @State private var animatedIdealPercent: Double = 0.0
    @State private var animatedFatToLose: Double = 0.0
    @State private var animatedBmiMethod: Double = 0.0
    @State private var input = ""
    
    var body: some View {
        
        VStack {
            HStack {
                Button {
                    route.navigateBack()
                } label: {
                    Image(systemName: "arrow.left")
                        .font(.title)
                        .foregroundColor(.black)
                }
                
                Text(localizedkey: "abc_bodyFatresult")
                    .frame(maxWidth: .infinity)
                    .font(.system(size: 20))
                    .bold()
                
                Image("information")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30)
            }
            .padding()
            
            VStack {
                ScrollView {
                    HStack {
                        Text(input == "man" ? "2%" : "10%")
                            .padding(.top, 40)
                        Image(gender == "man" ? "yellow" : "woman")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 22)
                        Text(input == "man" ? "6%" : "14%")
                            .padding(.top, 40)
                        Image(gender == "man" ? "green" : "woman2")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 22)
                        Text(input == "man" ? "14%" : "21%")
                            .padding(.top, 40)
                        Image(gender == "man" ? "green1" : "woman3")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20)
                        Text(input == "man" ? "18%" : "25%")
                            .padding(.top, 40)
                        Image(gender == "man" ? "orange" : "woman4")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20)
                        Text(input == "man" ? "25%" : "32%")
                            .padding(.top, 40)
                        Image(gender == "man" ? "red" : "woman5")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 22)
                    }
                    ZStack(alignment: .leading) {
                        Rectangle()
                            .fill(
                                LinearGradient(
                                    gradient: Gradient(colors: [.red, .yellow, .green.opacity(0.3), .green, .orange, .red]),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .frame(height: 20)

                        // MARKER
                        GeometryReader { geo in
                            let markerPosition = max(0, min(bodyFatPercentage / 40.0, 1)) * geo.size.width // 40 là max %
                            Rectangle()
                                .fill(Color.black)
                                .frame(width: 2, height: 30)
                                .offset(x: markerPosition - 1, y: -5) // -1 để căn giữa
                        }
                    }
                    .frame(height: 30)
                    .padding()
                    .padding(.top, -30)

                    HStack {
                        Text(localizedkey: "abc_Essential")
                            .font(.system(size: 12))
                            .padding(.top, -23)
                            .padding(.leading, 20)
                        
                        Text(localizedkey: "abc_Athletes")
                            .font(.system(size: 12))
                            .padding(.top, -23)
                            .padding(.leading, 30)
                        
                        Text(localizedkey: "abc_Fitness")
                            .font(.system(size: 12))
                            .padding(.top, -23)
                            .padding(.leading, 13)
                        
                        Text(localizedkey: "abc_Average")
                            .font(.system(size: 12))
                            .padding(.top, -23)
                            .padding(.leading, 10)
                        
                        Text(localizedkey: "abc_Obese")
                            .font(.system(size: 12))
                            .padding(.top, -23)
                            .padding(.leading, 30)
                    }
                    
                    VStack {
                        Text(String(format: "Body Fat: %.1f%%", animatedFat))
                            .font(.title2)
                            .bold()
                            .padding(5)
                        Text(category)
                            .padding(.top, -13)
                            .foregroundColor(.yellow)
                            .font(.title3)
                            .bold()
                        
                        HStack {
                            Text(localizedkey: "abc_bodyfat")
                                .frame(width: 250)
                                .padding()
                                .background(Color.gray.opacity(0.3))
                                .cornerRadius(13)
                            
                            Text(String(format: "%.1f%%", animatedFatMass))
                                .padding()
                                .background(Color.gray.opacity(0.3))
                                .cornerRadius(13)
                        }
                        
                        HStack {
                            Text(localizedkey: "abc_BodyFatcategory")
                                .frame(width: 250)
                                .padding()
                                .background(Color.gray.opacity(0.3))
                                .cornerRadius(13)
                            
                            Text("(\(category))")
                                .padding()
                                .background(Color.gray.opacity(0.3))
                                .cornerRadius(13)
                        }
                        HStack {
                            Text(localizedkey: "abc_BodyFatMass")
                                .frame(width: 250)
                                .padding()
                                .background(Color.gray.opacity(0.3))
                                .cornerRadius(13)
                            
                            Text(String(format: "%.1f %@", animatedFatMass, unit))
                                .padding()
                                .background(Color.gray.opacity(0.3))
                                .cornerRadius(13)
                        }
                        HStack {
                            Text(localizedkey: "abc_LeanBodyMass")
                                .frame(width: 250)
                                .padding()
                                .background(Color.gray.opacity(0.3))
                                .cornerRadius(13)
                            
                            Text(String(format: "%.1f %@", animatedLeanMass, unit))
                                .padding()
                                .background(Color.gray.opacity(0.3))
                                .cornerRadius(13)
                        }
                        
                        HStack {
                            Text(localizedkey: "abc_IdealBody")
                                .frame(width: 250)
                                .padding()
                                .background(Color.gray.opacity(0.3))
                                .cornerRadius(13)
                            
                            Text(String(format: "%.1f% %", animatedIdealPercent))
                                .frame(height: 40)
                                .padding()
                                .background(Color.gray.opacity(0.3))
                                .cornerRadius(13)
                        }
                        
                        HStack {
                            Text(localizedkey: "abc_BodyFatto")
                                .frame(width: 250)
                                .padding()
                                .background(Color.gray.opacity(0.3))
                                .cornerRadius(13)
                            
                            Text(String(format: "%.1f %@", animatedFatToLose, unit))
                                .padding()
                                .background(Color.gray.opacity(0.3))
                                .cornerRadius(13)
                        }
                        
                        HStack {
                            Text(localizedkey: "abc_BMImethod")
                                .frame(width: 250)
                                .padding()
                                .background(Color.gray.opacity(0.3))
                                .cornerRadius(13)
                            
                            Text(String(format: "%.1f%%", animatedBmiMethod))
                                .padding()
                                .background(Color.gray.opacity(0.3))
                                .cornerRadius(13)
                        }
                    }
                }
                
                HStack {
                    Button {
                        route.navigateBack()
                    } label: {
                        Text(localizedkey: "abc_tryAgain")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green)
                            .foregroundStyle(Color.white)
                            .bold()
                            .cornerRadius(13)
                    }
                    
                    Button {
                        route.navigateTo(.home)
                    } label: {
                        Text(localizedkey: "abc_home")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.gray.opacity(0.4))
                            .foregroundStyle(Color.black)
                            .bold()
                            .cornerRadius(13)
                    }
                }
                .padding()
                Spacer()
            }
        }
        .onAppear {
            animateAllValues()
        }
    }
    
    func animateAllValues() {
        startAnimation($animatedFat, to: bodyFatPercentage)
        startAnimation($animatedFatMass, to: fatMass)
        startAnimation($animatedLeanMass, to: leanMass)
        startAnimation($animatedIdealPercent, to: idealFatPercent)
        startAnimation($animatedFatToLose, to: fatToLose)
        startAnimation($animatedBmiMethod, to: bmiMethodFat)
    }


    func startAnimation(_ value: Binding<Double>, to target: Double) {
        value.wrappedValue = 0.0
        Timer.scheduledTimer(withTimeInterval: 0.02, repeats: true) { timer in
            if value.wrappedValue >= target {
                value.wrappedValue = target
                timer.invalidate()
            } else {
                value.wrappedValue += max(target / 50, 0.1)
            }
        }
    }
}

//#Preview {
//    BodyFatResult()
//}
