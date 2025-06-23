//
//  BodyFatResult.swift
//  Health_Weight
//
//  Created by Boss on 23/06/2025.
//

import SwiftUI

struct BodyFatResult: View {
    @EnvironmentObject var route: Router
    let bmr: Double
    let tdee: Double
    let unit: String
    @State private var animatedBMR: Int = 0
    @State private var animatedTDEE: Int = 0
    @State private var timer: Timer?
    
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
                        Text("2%")
                            .padding(.top, 40)
                        Image("yellow")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 22)
                        Text("6%")
                            .padding(.top, 40)
                        Image("green")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 22)
                        Text("14%")
                            .padding(.top, 40)
                        Image("green1")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20)
                        Text("18%")
                            .padding(.top, 40)
                        Image("orange")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20)
                        Text("25%")
                            .padding(.top, 40)
                        Image("red")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 22)
                    }
                    Rectangle()
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [.red, .yellow, .green.opacity(0.3), .green, .orange, .red]),
                                startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/,
                                endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/)
                        )
                        .frame(height: 20)
                        .padding()
                        .padding(.top, -30)
                    
                    
                    HStack {
                        Text("Essential \nFat")
                            .font(.system(size: 12))
                            .padding(.top, -23)
                            .padding(.leading, 20)
                        
                        Text("Athletes")
                            .font(.system(size: 12))
                            .padding(.top, -23)
                            .padding(.leading, 30)
                        
                        Text("Fitness")
                            .font(.system(size: 12))
                            .padding(.top, -23)
                            .padding(.leading, 13)
                        
                        Text("Average")
                            .font(.system(size: 12))
                            .padding(.top, -23)
                            .padding(.leading, 10)
                        
                        Text("Obese")
                            .font(.system(size: 12))
                            .padding(.top, -23)
                            .padding(.leading, 30)
                    }
                    
                    VStack {
                        Text("Boy Fat: 18.3%")
                            .font(.title2)
                            .bold()
                            .padding(5)
                        Text("(Average)")
                            .padding(.top, -13)
                            .foregroundColor(.yellow)
                            .font(.title3)
                            .bold()
                        
                        HStack {
                            Text("Body Fat (U.S. Navy Method)")
                                .frame(width: 250)
                                .padding()
                                .background(Color.gray.opacity(0.3))
                                .cornerRadius(13)
                            
                            Text("18.3%")
                                .padding()
                                .background(Color.gray.opacity(0.3))
                                .cornerRadius(13)
                        }
                        
                        HStack {
                            Text("Body Fat category")
                                .frame(width: 250)
                                .padding()
                                .background(Color.gray.opacity(0.3))
                                .cornerRadius(13)
                            
                            Text("Avarage")
                                .padding()
                                .background(Color.gray.opacity(0.3))
                                .cornerRadius(13)
                        }
                        HStack {
                            Text("Body Fat Mass")
                                .frame(width: 250)
                                .padding()
                                .background(Color.gray.opacity(0.3))
                                .cornerRadius(13)
                            
                            Text("9.7 kgs")
                                .padding()
                                .background(Color.gray.opacity(0.3))
                                .cornerRadius(13)
                        }
                        HStack {
                            Text("Leab Body Mass")
                                .frame(width: 250)
                                .padding()
                                .background(Color.gray.opacity(0.3))
                                .cornerRadius(13)
                            
                            Text("43.3 kgs")
                                .padding()
                                .background(Color.gray.opacity(0.3))
                                .cornerRadius(13)
                        }
                        
                        HStack {
                            Text("Ideal Body Fat for Given Age \n (Jackson & Pollard")
                                .frame(width: 250)
                                .padding()
                                .background(Color.gray.opacity(0.3))
                                .cornerRadius(13)
                            
                            Text("11.4%")
                                .frame(height: 40)
                                .padding()
                                .background(Color.gray.opacity(0.3))
                                .cornerRadius(13)
                        }
                        
                        HStack {
                            Text("Body Fat to Lose to Reach Ideal")
                                .frame(width: 250)
                                .padding()
                                .background(Color.gray.opacity(0.3))
                                .cornerRadius(13)
                            
                            Text("3.6 kgs")
                                .padding()
                                .background(Color.gray.opacity(0.3))
                                .cornerRadius(13)
                        }
                        
                        HStack {
                            Text("Body Fat (BMI method)")
                                .frame(width: 250)
                                .padding()
                                .background(Color.gray.opacity(0.3))
                                .cornerRadius(13)
                            
                            Text("13.9 kgs")
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

//#Preview {
//    BodyFatResult()
//}
