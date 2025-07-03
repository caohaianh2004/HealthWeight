//
//  AddWeight.swift
//  Health_Weight
//
//  Created by Boss on 11/06/2025.
//

import SwiftUI
import SlidingRuler

struct AddWeight: View {
    @EnvironmentObject var route: Router
    @State private var selectionKg: Double = .zero
    @State private var weightkg: Double = .zero
    @State private var weightlb: Double = .zero
    @StateObject var viewModel = UserViewModel()
    @State private var selectedTab = 1
    
    var body: some View {
        VStack {
            addWeightTopbar()
            Spacer()
            
            VStack {
                ForEach(viewModel.people) { person in
                    Image(person.image)
                        .resizable().scaledToFit()
                        .frame(width: 200)
                }
                Text(String(format: "Current Weight (%.1f %@)", selectedTab == 0 ? weightlb : weightkg, selectedTab == 0 ? "lb" : "kg"))
                    .font(.system(size: 18))
                    .foregroundStyle(Color.green)
                
                SlidingRuler (
                    value: selectedTab == 0 ? $weightlb : $weightkg,
                    in: 0...269,
                    step: 1,
                    snap: .fraction,
                    tick: .fraction
                )
                .padding()
                .onChange(of: weightkg) { newValue in
                    if selectedTab == 1 {
                        weightlb = newValue * 2.20462
                        updateWeightInDatabase(weight: newValue)
                    }
                }
                .onChange(of: weightlb) { newValue in
                    if selectedTab == 0 {
                        weightkg = newValue / 2.20462
                        updateWeightInDatabase(weight: weightkg)
                    }
                }
                
                if let person = viewModel.people.first {
                    MeasuringmachineUpdated(
                        weight: selectedTab == 0 ? weightlb : weightkg,
                        heightCm: person.heightCm,
                        heightFt: person.heightFt,
                        heightIn: person.heightln,
                        selectedTab: selectedTab
                    )
                }
            }
            Spacer()
        }

        .onAppear {
            selectedTab = UserDefaults.standard.integer(forKey: "selectedTab")
            viewModel.fetchPeople()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                if let person = viewModel.people.first {
                    weightkg = person.weightKg
                    weightlb = person.weightKg * 2.20462
                }
            }
        }

        .onChange(of: selectionKg) { newValue in
            if let person = viewModel.people.first,
               let id = person.id {
                viewModel.people[0].weightKg = newValue
                DatabasePeople.shared.updateWeight(for: id, newWeight: newValue)
            }
        }
    }
    
    private func updateWeightInDatabase(weight: Double) {
        if let person = viewModel.people.first,
           let id = person.id {
            viewModel.people[0].weightKg = weight
            DatabasePeople.shared.updateWeight(for: id, newWeight: weight)
        }
    }
    
    private var formatter: NumberFormatter {
        let f = NumberFormatter()
        f.numberStyle = .percent
        f.maximumFractionDigits = 0
        return f
    }
    
    @ViewBuilder
    func addWeightTopbar() -> some View {
        HStack {
            Button {
                route.navigateBack()
            }label: {
                Image(systemName: "arrow.left")
                    .foregroundColor(.black)
                    .font(.title)
            }
            
            Spacer()
            
            Text(localizedkey: "abc_weightToday")
                .font(.headline)
            
            Spacer()
            
            Button {
                route.navigateTo(.home)
            } label: {
                Text(localizedkey: "abc_next")
                    .padding(10)
                    .foregroundStyle(Color.white)
                    .background(Color.green)
                    .cornerRadius(15)
            }
        }
        .padding()
    }
}



struct MeasuringmachineUpdated: View {
    var weight: Double     // kg hoặc lb
    var heightCm: Double   // dùng cho Metric
    var heightFt: Double   // dùng cho US
    var heightIn: Double   // dùng cho US
    var selectedTab: Int   // 0 = US Units, 1 = Metric
    
    var currentBMI: Double {
        if selectedTab == 0 {
            // US Units: BMI = (lb * 703) / (in * in)
            let totalInch = (heightFt * 12) + heightIn
            return totalInch > 0 ? (weight * 703) / (totalInch * totalInch) : 0
        } else {
            // Metric: BMI = kg / (m * m)
            let heightInMeter = heightCm / 100
            return heightInMeter > 0 ? weight / (heightInMeter * heightInMeter) : 0
        }
    }
    
    let bmiZones: [(range: ClosedRange<Double>, label: String, color: Color)] = [
        (0...16.0, "Severe Thinness", .blue),
        (16.1...17.0, "Moderate Thinness", .blue.opacity(0.5)),
        (17.1...18.4, "Mild Thinness", .blue.opacity(0.3)),
        (18.5...25.0, "Normal", .green),
        (25.1...30.0, "Overweight", .yellow),
        (30.1...34.9, "Obese I", .orange),
        (35.0...39.9, "Obese II", .red.opacity(0.7)),
        (40.0...269.0, "Obese III", .red)
    ]
    
    var bmiCategoryLabel: String {
        bmiZones.first(where: { $0.range.contains(currentBMI) })?.label ?? "Unknown"
    }
    
    var bmiCategoryColor: Color {
        bmiZones.first(where: { $0.range.contains(currentBMI) })?.color ?? .gray
    }
    
    let minAngle: Double = -97
    let maxAngle: Double = 97
    let minBMI: Double = 0
    let maxBMI: Double = 60
    
    var needleAngle: Double {
        let clampedBMI = min(max(currentBMI, minBMI), maxBMI)
        let ratio = (clampedBMI - minBMI) / (maxBMI - minBMI)
        return minAngle + ratio * (maxAngle - minAngle)
    }
    
    var body: some View {
        VStack(spacing: 12) {
            ZStack {
                Image("control")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300)
                
                Image("needle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30)
                    .padding(.top, 20)
                    .rotationEffect(.degrees(needleAngle), anchor: .bottom)
                    .offset(y: -10)
            }
            
            Text(String(format: "BMI = %.1f %@", currentBMI, selectedTab == 0 ? "lb/in²" : "kg/m²"))
                .font(.title3)
                .bold()
            
            Text("(\(bmiCategoryLabel))")
                .font(.system(size: 18))
                .bold()
                .foregroundColor(bmiCategoryColor)
        }
        .animation(.easeInOut(duration: 0.4), value: currentBMI)
    }
}


#Preview {
    AddWeight()
}
