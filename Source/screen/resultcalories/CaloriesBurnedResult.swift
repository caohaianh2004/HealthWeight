//
//  CaloriesBurnedResult.swift
//  Health_Weight
//
//  Created by Boss on 30/06/2025.
//

import SwiftUI

struct CaloriesBurnedResult: View {
    let resultCalories: Double
    @EnvironmentObject var route: Router
    @State private var animatedResult: Double = 0
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    route.navigateBack()
                } label: {
                    Image(systemName: "arrow.left")
                        .foregroundColor(.black)
                        .font(.title2)
                }
                
                Text(localizedkey: "abc_caloriesResult")
                    .font(.system(size: 18))
                    .bold()
                    .frame(maxWidth: .infinity)
                
                Button {
                    
                } label: {
                    Image("information")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20)
                }
            }
            .padding()
            
            Image("kcal")
                .resizable()
                .scaledToFit()
                .frame(width: 150)
            
            Text(localizedkey: "abc_textkcal")
                .multilineTextAlignment(.center)
            
            HStack {
                Text(String(format: "%.1f", animatedResult))
                    .font(.title)
                    .foregroundColor(.green)

                Text("calories")
                    .font(.title)
                    .foregroundColor(.green)
            }
            Text(localizedkey: "abc_textk")
            
            Spacer()
            Buttontoobal()
        }
        .onAppear {
            animatedResult = 0
            Timer.scheduledTimer(withTimeInterval: 0.02, repeats: true) { timer in
                if animatedResult < resultCalories {
                    animatedResult += 0.5
                } else {
                    animatedResult = resultCalories
                    timer.invalidate()
                }
            }
        }

        Spacer()
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
}

