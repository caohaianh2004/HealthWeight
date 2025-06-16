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
    @State private var selectionKg: Double = 10.0
    @StateObject var viewModel = UserViewModel()
    
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
                Text(String(format: "Current Weight (%.1f kg)", selectionKg))
                    .font(.system(size: 18))
                    .foregroundStyle(Color.green)
                
                SlidingRuler (
                    value: $selectionKg,
                    in: 0...269,
                    step: 1,
                    snap: .fraction,
                    tick: .fraction
                )
                .padding()
                
                if let person = viewModel.people.first {
                       Measuringmachine(weight: selectionKg, height: person.heightCm)
                   }
            }
            .onAppear {
                viewModel.fetchPeople()
            }
            Spacer()
        }
        .onAppear {
            viewModel.fetchPeople()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                if let person = viewModel.people.first {
                    selectionKg = person.weightKg
                }
            }
        }
        .onChange(of: selectionKg) { newValue in
            if let person = viewModel.people.first, let id = person.id {
                viewModel.people[0].weightKg = newValue
                DatabasePeople.shared.updateWeight(for: id, newWeight: newValue)
            }
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

struct Measuringmachine: View {
    var weight: Double     // kg
    var height: Double     // cm

    // BMI = weight (kg) / height^2 (m)
    var currentBMI: Double {
        let heightInMeter = height / 100
        return heightInMeter > 0 ? weight / (heightInMeter * heightInMeter) : 0
    }

    // Vùng chỉ số BMI
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

    // Góc quay của kim đo (ví dụ từ -92 đến +92 độ)
    let minAngle: Double = -97
    let maxAngle: Double = 97
    let minBMI: Double = 0
    let maxBMI: Double = 60

    var needleAngle: Double {
        // Clamp BMI vào khoảng cho phép
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

            Text(String(format: "BMI = %.1f kg/m2", currentBMI))
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
