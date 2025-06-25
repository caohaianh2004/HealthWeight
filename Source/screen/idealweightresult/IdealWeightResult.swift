//
//  IdealWeightResult.swift
//  Health_Weight
//
//  Created by Boss on 25/06/2025.
//

import SwiftUI

struct IdealWeightResult: View {
    @EnvironmentObject var route: Router
    let robinson: Double
       let miller: Double
       let devine: Double
       let hamwi: Double
       let healthyMin: Double
       let healthyMax: Double
       let unit: String
    
    @State private var animatedRobinson: Double = 0.0
    @State private var animatedMiller: Double = 0.0
    @State private var animatedDevine: Double = 0.0
    @State private var animatedHamwi: Double = 0.0
    @State private var animatedHealthyMin: Double = 0.0
    @State private var animatedHealthyMax: Double = 0.0

    
    var body: some View {
        VStack {
            HStack {
                Button {
                    route.navigateBack()
                } label: {
                    Image(systemName: "arrow.left")
                        .font(.title2)
                        .foregroundColor(.black)
                }
                
                Spacer()
                Text(localizedkey: "abc_idelresult")
                    .font(.system(size: 18))
                    .bold()
                Spacer()
                
                Button {
                    
                } label: {
                    Image("information")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20)
                }
            }
            .padding()
            
                VStack {
                    Image("idel")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 350)
                    Text(localizedkey: "abc_textideal")
                        .padding(10)
                        .bold()
                        .font(.system(size: 17))
                    
                    VStack {
                        HStack {
                            Text(localizedkey: "abc_formula")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(10)
                                .background(Color.green)
                                .bold()
                                .font(.system(size: 15))
                                .cornerRadius(10)
                            
                            Spacer()
                            
                            Text(localizedkey: "abc_idelWeight")
                                .frame(maxWidth: .infinity)
                                .padding(10)
                                .background(Color.green)
                                .bold()
                                .font(.system(size: 15))
                                .cornerRadius(10)
                        }
                        
                        HStack {
                            Text(localizedkey: "abc_robinson")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(10)
                                .background(Color.gray.opacity(0.3))
                                .font(.system(size: 15))
                                .cornerRadius(10)
                            
                            Spacer()
                            
                            Text(String(format: "%.1f %@", animatedRobinson, unit))
                                .frame(maxWidth: .infinity)
                                .padding(10)
                                .background(Color.gray.opacity(0.3))
                                .font(.system(size: 15))
                                .cornerRadius(10)
                        }
                        
                        HStack {
                            Text(localizedkey: "abc_miller")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(10)
                                .background(Color.gray.opacity(0.3))
                                .font(.system(size: 15))
                                .cornerRadius(10)
                            
                            Spacer()
                            
                            Text(String(format: "%.1f %@", animatedMiller, unit))
                                .frame(maxWidth: .infinity)
                                .padding(10)
                                .background(Color.gray.opacity(0.3))
                                .font(.system(size: 15))
                                .cornerRadius(10)
                        }
                        
                        HStack {
                            Text(localizedkey: "abc_devine")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(10)
                                .background(Color.gray.opacity(0.3))
                                .font(.system(size: 15))
                                .cornerRadius(10)
                            
                            Spacer()
                            
                            Text(String(format: "%.1f %@", animatedDevine, unit))
                                .frame(maxWidth: .infinity)
                                .padding(10)
                                .background(Color.gray.opacity(0.3))
                                .font(.system(size: 15))
                                .cornerRadius(10)
                        }
                        
                        
                        HStack {
                            Text(localizedkey: "abc_hamwi")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(10)
                                .background(Color.gray.opacity(0.3))
                                .font(.system(size: 15))
                                .cornerRadius(10)
                            
                            Spacer()
                            
                            Text(String(format: "%.1f %@", animatedHamwi, unit))
                                .frame(maxWidth: .infinity)
                                .padding(10)
                                .background(Color.gray.opacity(0.3))
                                .font(.system(size: 15))
                                .cornerRadius(10)
                        }
                        
                        
                        HStack {
                            Text(localizedkey: "abc_healthybmi")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(10)
                                .background(Color.gray.opacity(0.3))
                                .font(.system(size: 15))
                                .cornerRadius(10)
                            
                            Spacer()
                            
                            Text(String(format: "%.1f - %.1f %@", animatedHealthyMin, animatedHealthyMax, unit))
                                .frame(maxWidth: .infinity)
                                .padding(10)
                                .background(Color.gray.opacity(0.3))
                                .font(.system(size: 15))
                                .cornerRadius(10)
                        }
                    }
                    .padding()
                }
            buttonideal()
        }
        .onAppear {
            animateAll()
        }
    }
    
    func buttonideal() -> some View {
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
    
    func animate(to target: Double, value: Binding<Double>) {
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

    func animateAll() {
        animate(to: robinson, value: $animatedRobinson)
        animate(to: miller, value: $animatedMiller)
        animate(to: devine, value: $animatedDevine)
        animate(to: hamwi, value: $animatedHamwi)
        animate(to: healthyMin, value: $animatedHealthyMin)
        animate(to: healthyMax, value: $animatedHealthyMax)
    }

}


