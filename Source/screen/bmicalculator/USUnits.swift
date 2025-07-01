//
//  USUnits.swift
//  Health_Weight
//
//  Created by Boss on 12/06/2025.
//

import SwiftUI
import SlidingRuler

struct USUnits: View {
    enum Gender {
        case man
        case woden
    }
    enum EditingField {
        case none, weightpound, age
    }
    @State private var selectionGender: Gender = .man
    @State private var input = ""
    @State private var isShowDialog = false
    @State private var weightlb = 196.2
    @State private var age = 20
    @State private var editingField: EditingField = .none
    @State private var valueft: Double = .zero
    @State private var valuein: Double = .zero
    @StateObject private var viewModel = UserViewModel()
    @EnvironmentObject var route: Router
    
    var body: some View {
        ZStack {
            VStack {
                ScrollView {
                    HStack {
                        ForEach(viewModel.people) { person in
                            Image(person.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 200)
                        }
                    }
                    Text(String(format: "Height(165cm) (%.1f ft %.1f in)", valueft, valuein))
                        .foregroundStyle(Color.green)
                    
                    SlidingRuler (
                        value: $valueft,
                        in: 1...7,
                        step: 1,
                        snap: .fraction,
                        tick: .fraction
                    )
                    .padding(10)
                    
                    Text(localizedkey: "abc_ft")
                    
                    SlidingRuler (
                        value: $valuein,
                        in: 0...12,
                        step: 1,
                        snap: .fraction,
                        tick: .fraction
                    )
                    .padding(10)
                    
                    Text(localizedkey: "abc_in")
                    
                    HStack(spacing: 20) {
                        stepperBox(title: "Weight(lb)", value: $weightlb, field: .weightpound)
                            .padding(20)
                            .background(.gray.opacity(0.2))
                            .cornerRadius(12)
                        
                        stepperBoxAge(title: "Age", value: $age, field: .age)
                            .padding(20)
                            .background(.gray.opacity(0.2))
                            .cornerRadius(12)
                    }
                }
                Button {
                    let totalHeight = (valueft * 12) + valuein
                    let bmi = calculateBMI(weightLb: weightlb, heightInch: totalHeight)
                    let healthyRange = healthyWeightRange(ft: valueft, inch: valuein)
                    
                    route.navigateTo(.bmiresult(bmi: bmi, healthWeightRange: healthyRange))
                } label: {
                    Text(localizedkey: "abc_calculate")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .frame(width: 350)
                        .background(Color.green)
                        .font(.system(size: 18))
                        .bold()
                        .foregroundStyle(Color.white)
                        .cornerRadius(14)
                }
                Spacer()
            }
            .onAppear {
                viewModel.fetchPeople()
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    if let person = viewModel.people.first {
                        valueft = person.heightFt
                        valuein = person.heightln
                        weightlb = person.weightLb
                        age = person.age
                    }
                }
            }
            ChooseWeight(isShowDialog: $isShowDialog, input: $input)
                .onChange(of: isShowDialog) { newValue in
                    if !newValue {
                        DispatchQueue.main.async {
                            if let value = Double(input) {
                                switch editingField {
                                case .weightpound: weightlb = Double(value)
                                case .age: age = Int(value)
                                default: break
                                }
                            }
                            editingField = .none
                        }
                    }
                }
        }
    }
    
    private var formatter: NumberFormatter {
        let f = NumberFormatter()
        f.numberStyle = .percent
        f.maximumFractionDigits = 0
        return f
    }
    
    func calculateBMI(weightLb: Double, heightInch: Double) -> Double {
        guard heightInch > 0 else {return 0}
        return (weightLb * 703) / (heightInch * heightInch)
    }
    
    func healthyWeightRange(ft: Double, inch: Double) -> String {
        let heightInInch = (ft * 12) + inch
        let min = (18.5 * heightInInch * heightInInch) / 703
        let max = (24.9 * heightInInch * heightInInch) / 703
        return String(format: "%.1f lb - %.1f lb", min, max)
    }
    
    private func stepperBox(title: String, value: Binding<Double>, field: EditingField) -> some View {
        VStack {
            Text(title).bold()
            HStack {
                stepperButton("-", action: { value.wrappedValue -= 1 })
                Text(String(format: "%.1f", value.wrappedValue))
                    .font(.title3)
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
    
    private func stepperBoxAge(title: String, value: Binding<Int>, field: EditingField) -> some View {
        VStack {
            Text(title).bold()
            HStack {
                stepperButton("-", action: { value.wrappedValue -= 1 })
                Text("\(value.wrappedValue)")
                    .font(.title3)
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
    USUnits()
}
