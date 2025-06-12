//
//  BmiResult.swift
//  Health_Weight
//
//  Created by Boss on 11/06/2025.
//

import SwiftUI

struct BmiResult: View {
    @EnvironmentObject var route: Router
    
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
              Text("BMI = 23 kg/m2")
                    .bold()
              Text("(Normal)")
                    .font(.headline)
                    .foregroundStyle(Color.green)
                
              Text(localizedkey: "abc_bmiResult")
                   
              Text("49,2kg - 66.4kg")
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
    }
    
    @ViewBuilder
    func ControlNeedle() -> some View {
        VStack {
            ZStack {
                Image("control")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300)
                
                Image("needle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30)
                    .padding(.top, 40)
            }
        }
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

#Preview {
    BmiResult()
}
