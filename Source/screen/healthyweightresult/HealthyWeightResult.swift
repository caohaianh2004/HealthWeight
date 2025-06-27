//
//  HealthyWeightResult.swift
//  Health_Weight
//
//  Created by Boss on 26/06/2025.
//

import SwiftUI

struct HealthyWeightResult: View {
    let minWeight: Double
    let maxWeight: Double
    let unit: String
    @EnvironmentObject var route: Router
    let sections: [(color: Color, label: String)] = [
        (.red, "Dangerously Low"),
        (.green.opacity(0.7), "Excellent"),
        (.green, "Good"),
        (.green.opacity(0.7), "Fair"),
        (.yellow.opacity(0.8), "Poor"),
        (.orange, "Very Poor"),
        (.red, "Dangerously High")
    ]
    @State private var animatedMin: Double = 0.0
    @State private var animatedMax: Double = 0.0
    
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
                
                Text(localizedkey: "abc_healthweightresult")
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
            
            Image("bannerhwr")
                .resizable()
                .scaledToFit()
                .frame(width: 300)
            
            VStack(spacing: 4) {
                // Số chia đều theo đoạn màu
                HStack(spacing: 0) {
                    ForEach(0..<sections.count + 1, id: \.self) { index in
                        let step = (maxWeight - minWeight) / Double(sections.count)
                        let value = minWeight + (Double(index) * step)
                        Text(String(format: "%.0f", value))
                            .font(.caption2)
                            .frame(maxWidth: .infinity)
                    }
                }

                // Thanh màu
                HStack(spacing: 0) {
                    ForEach(sections, id: \.label) { section in
                        Rectangle()
                            .fill(section.color)
                            .frame(maxWidth: .infinity)
                            .overlay(
                                Rectangle()
                                    .stroke(Color.black, lineWidth: 0.5)
                            )
                    }
                }
                .frame(height: 30)
                
                // Label của từng đoạn
                HStack(spacing: 0) {
                    ForEach(sections, id: \.label) { section in
                        Text(section.label)
                            .font(.caption2)
                            .minimumScaleFactor(0.5)
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: .infinity)
                    }
                }
            }
            .padding(.horizontal)

            
            Text(localizedkey: "abc_texthwr")
                .font(.system(size: 15))
                .bold()
            
            Text(String(format: "%.1f %@ - %.1f %@", animatedMin, unit, animatedMax, unit))
                .font(.title2)
                .bold()
                .foregroundStyle(Color.green)


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
        .onAppear {
            animateWeight(from: 0.0, to: minWeight) { value in
                animatedMin = value
            }
            animateWeight(from: 0.0, to: maxWeight) { value in
                animatedMax = value
            }
        }

        Spacer()
    }
    func animateWeight(from: Double, to: Double, update: @escaping (Double) -> Void) {
        var value = from
        let step = max((to - from) / 50, 0.1)
        
        Timer.scheduledTimer(withTimeInterval: 0.02, repeats: true) { timer in
            value += step
            if value >= to {
                value = to
                timer.invalidate()
            }
            update(value)
        }
    }

}


