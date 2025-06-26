
//
//  HealthyUS.swift
//  Health_Weight
//
//  Created by Boss on 26/06/2025.
//

import SwiftUI
import SlidingRuler

struct HealthyMetric: View {
    @EnvironmentObject var route: Router
    @StateObject var viewModel = UserViewModel()
    @State private var heightCm: Double = .zero
    @State private var gender: String = "man"
    
    var body: some View {
        VStack {
            ForEach(viewModel.people) { person in
                Image(person.image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200)
            }
            
            Text(String(format: "Height(165 cm) (%.1f cm)", heightCm))
                .foregroundStyle(Color.green)
                .bold()
            
            SlidingRuler(
                value: $heightCm,
                in: 30...250,
                snap: .fraction,
                tick: .fraction
            )
            
             Spacer()
            buttoncalculate()
        }
        .onAppear {
            viewModel.fetchPeople()
            if let person = viewModel.people.first {
                heightCm = person.heightCm
                
                if person.image == "Image7" {
                    gender = "woman"
                } else {
                    gender = "man"
                }
            }
        }
    }
    
    func buttoncalculate() -> some View {
        Button {
            let range = healthyWeightRange(heightCm: heightCm)
                 
                 route.navigateTo(.healthyweightresult(
                     minWeight: range.min,
                     maxWeight: range.max,
                     unit: "kg"
                 ))
        } label: {
            Text(localizedkey: "abc_calculate")
                .padding()
                .bold()
                .frame(maxWidth: .infinity)
                .font(.system(size: 18))
                .foregroundColor(.white)
                .background(Color.green)
                .cornerRadius(12)
                .padding()
        }
    }
    
    func healthyWeightRange(heightCm: Double) -> (min: Double, max: Double) {
        let heightM = heightCm / 100
        let minKg = 18.5 * pow(heightM, 2)
        let maxKg = 24.9 * pow(heightM, 2)
        return (minKg, maxKg)
    }

}

#Preview {
    HealthyMetric()
}
