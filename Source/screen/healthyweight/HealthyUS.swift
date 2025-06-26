//
//  HealthyMetric.swift
//  Health_Weight
//
//  Created by Boss on 26/06/2025.
//

import SwiftUI
import SlidingRuler

struct HealthyUS: View {
    @EnvironmentObject var route: Router
    @StateObject var viewModel = UserViewModel()
    @State private var heightft: Double = .zero
    @State private var heightin: Double = .zero
    @State private var gender: String = "man"
    
    var body: some View {
        VStack {
            ForEach(viewModel.people) { person in
                Image(person.image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200)
            }
            Text(String(format: "Height(165 cm) (%.1f ft %.1f in)", heightft, heightin))
                .foregroundStyle(Color.green)
                .bold()
            
            SlidingRuler(
                value: $heightft,
                in: 1...7,
                snap: .fraction,
                tick: .fraction
            )
            .padding(10)
            
            Text(localizedkey: "abc_ft")
                .font(.system(size: 12))
            
            SlidingRuler(
                value: $heightin,
                in: 0...12,
                snap: .fraction,
                tick: .fraction
            )
            .padding(10)
            
            Text(localizedkey: "abc_in")
                .font(.system(size: 12))
            
            Spacer()
            buttoncalculate()
        }
        .onAppear {
            viewModel.fetchPeople()
            if let person = viewModel.people.first {
                heightft = person.heightFt
                heightin = person.heightln
                
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
}

#Preview {
    HealthyUS()
}
