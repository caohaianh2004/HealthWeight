//
//  IdealWeightMetric.swift
//  Health_Weight
//
//  Created by Boss on 25/06/2025.
//

import SwiftUI
import SlidingRuler

struct IdealWeightMetric: View {
    enum EditingField {
        case none, age
    }
    @EnvironmentObject var route: Router
    @StateObject private var viewModel = UserViewModel()
    @State private var heightCm: Double = .zero
    @State private var age: Int = .zero
    @State private var input = ""
    @State private var isShowDialog = false
    @State private var editingField: EditingField = .none
    @State private var gender = "man"
    
    var body: some View {
        ZStack {
            VStack {
                ForEach(viewModel.people) { person in
                    Image(person.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200)
                }
                Text(String(format: "Height(165 cm) (%.1f cm)", heightCm))
                    .foregroundStyle(Color.green)
                
                SlidingRuler(
                    value: $heightCm,
                    in: 30...250,
                    snap: .fraction,
                    tick: .fraction
                )
                .padding(10)
                
                stepperBoxAge(title: "Age", value: $age, field: .age)
                    .padding(20)
                    .background(.gray.opacity(0.2))
                    .cornerRadius(12)
                
                Spacer()
                buttonCalculate()
                Spacer()
            }
            
            .onAppear {
                viewModel.fetchPeople()
                if let person = viewModel.people.first {
                    heightCm = person.heightCm
                    age = person.age
                    
                    if person.image == "Image7" {
                        gender = "woman"
                    } else {
                        gender = "man"
                    }
                }
            }
            
            ChooseWeight(isShowDialog: $isShowDialog, input: $input)
                .onChange(of: isShowDialog) { newValue in
                    if !newValue {
                        DispatchQueue.main.async {
                            if let value = Int(input) {
                                switch editingField {
                                case .age:
                                    age = Int(value)
                                default: break
                                }
                            }
                            editingField = .none
                        }
                    }
                }
        }
    }
    
    func buttonCalculate() -> some View {
        Button {
            let robinson = robinsonKg()
                   let miller = millerKg()
                   let devine = devineKg()
                   let hamwi = hamwiKg()
                   let bmiMin = healthyBMIRange().min
                   let bmiMax = healthyBMIRange().max

                   route.navigateTo(.idealWeightResult(
                       robinson: robinson,
                       miller: miller,
                       devine: devine,
                       hamwi: hamwi,
                       healthyMin: bmiMin,
                       healthyMax: bmiMax,
                       unit: "kgs"
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
    
    func robinsonKg() -> Double {
        let heightInch = heightCm / 2.54
        let base = gender == "man" ? 52.0 : 49.0
        let perInch = gender == "man" ? 1.9 : 1.7
        return base + perInch * max(heightInch - 60, 0)
    }

    func millerKg() -> Double {
        let heightInch = heightCm / 2.54
        let base = gender == "man" ? 56.2 : 53.1
        let perInch = gender == "man" ? 1.41 : 1.36
        return base + perInch * max(heightInch - 60, 0)
    }

    func devineKg() -> Double {
        let heightInch = heightCm / 2.54
        let base = gender == "man" ? 50.0 : 45.5
        return base + 2.3 * max(heightInch - 60, 0)
    }

    func hamwiKg() -> Double {
        let heightInch = heightCm / 2.54
        let base = gender == "man" ? 48.0 : 45.5
        let perInch = gender == "man" ? 2.7 : 2.2
        return base + perInch * max(heightInch - 60, 0)
    }

    func healthyBMIRange() -> (min: Double, max: Double) {
        let heightM = heightCm / 100
        let min = 18.5 * heightM * heightM
        let max = 24.9 * heightM * heightM
        return (min, max)
    }
    
    private func stepperBoxAge(title: String, value: Binding<Int>, field: EditingField) -> some View {
        VStack {
            Text(title).bold()
            HStack {
                stepperButton("-", action: { value.wrappedValue -= 1 })
                Text("\(value.wrappedValue)")
                    .font(.system(size: 18))
                    .frame(width: 50)
                    .onTapGesture {
                        input = "\(value.wrappedValue)"
                        editingField = field
                        isShowDialog = true
                    }
                stepperButton("+", action: { value.wrappedValue += 1 })
            }
        }
    }
    
    private func stepperButton(_ symbol: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Text(symbol)
                .frame(width: 35, height: 35)
                .background(Color.black.opacity(0.05))
                .cornerRadius(8)
        }
    }

}

#Preview {
    IdealWeightMetric()
}
