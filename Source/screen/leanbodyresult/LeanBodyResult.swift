//
//  LeanBodyResult.swift
//  Health_Weight
//
//  Created by Boss on 25/06/2025.
//

import SwiftUI

struct LeanBodyResult: View {
    @EnvironmentObject var route: Router
    let boerlean: Double
    let boerbody: Double
    let jameslean: Double
    let jmmesbody: Double
    let humelean: Double
    let humebody: Double
    let unit: String
    @State private var animateBoerLean: Double = 0
    @State private var animateBoerFat: Double = 0
    @State private var animateJamesLean: Double = 0
    @State private var animateJamesFat: Double = 0
    @State private var animateHumeLean: Double = 0
    @State private var animateHumeFat: Double = 0

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
                Text(localizedkey: "abc_textlean")
                    .frame(maxWidth: .infinity)
                    .font(.system(size: 18))
                    .bold()
                Image("information")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20)
            }
            .padding()
            
            Image("basslean")
                .resizable()
                .scaledToFit()
                .frame(width: 300)
            
            Text(localizedkey: "abc_textresultlean")
                .font(.system(size: 16))
                .bold()
            VStack {
                HStack {
                    Text(localizedkey: "abc_formula")
                        .frame(width: 70)
                        .padding(10)
                        .font(.system(size: 15))
                        .background(Color.green)
                        .bold()
                        .cornerRadius(10)
                    
                    Text(localizedkey: "abc_leanbodymass")
                        .frame(width: 120)
                        .padding(10)
                        .font(.system(size: 15))
                        .background(Color.green)
                        .bold()
                        .cornerRadius(10)
                    
                    Text(localizedkey: "abc_bodyfatt")
                        .frame(width: 70)
                        .padding(10)
                        .font(.system(size: 15))
                        .background(Color.green)
                        .bold()
                        .cornerRadius(10)
                }
                resultRow(formula: "Boer^1", lean: animateBoerLean, fat: animateBoerFat, unit: unit)
                resultRow(formula: "James^2", lean: animateJamesLean, fat: animateJamesFat, unit: unit)
                resultRow(formula: "Hume^3", lean: animateHumeLean, fat: animateHumeFat, unit: unit)
            }

            Spacer()
            
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
        Spacer()
        
            .onAppear {
                animate(to: boerlean, value: $animateBoerLean)
                animate(to: boerbody, value: $animateBoerFat)
                animate(to: jameslean, value: $animateJamesLean)
                animate(to: jmmesbody, value: $animateJamesFat)
                animate(to: humelean, value: $animateHumeLean)
                animate(to: humebody, value: $animateHumeFat)
            }
    }
    
    @ViewBuilder
    func resultRow(formula: String, lean: Double, fat: Double, unit: String) -> some View {
        HStack {
            Text(formula)
                .frame(width: 70)
                .padding(10)
                .font(.system(size: 15))
                .background(Color.gray.opacity(0.4))
                .bold()
                .cornerRadius(10)
            
            Text(String(format: "%.1f \(unit) (%.0f%%)", lean, 100 - fat))
                .frame(width: 120)
                .padding(10)
                .font(.system(size: 15))
                .background(Color.gray.opacity(0.4))
                .bold()
                .cornerRadius(10)
            
            Text(String(format: "%.1f%%", fat))
                .frame(width: 70)
                .padding(10)
                .font(.system(size: 15))
                .background(Color.gray.opacity(0.4))
                .bold()
                .cornerRadius(10)
        }
    }


    func animate(to target: Double, value: Binding<Double>) {
        value.wrappedValue = 0.0
        Timer.scheduledTimer(withTimeInterval: 0.02, repeats: true) { timer in
            if value.wrappedValue >= target {
                value.wrappedValue = target
                timer.invalidate()
            } else {
                value.wrappedValue += max(target / 40, 0.1)
            }
        }
    }
}


