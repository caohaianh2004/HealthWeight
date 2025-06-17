//
//  MetricUnitS.swift
//  Health_Weight
//
//  Created by Boss on 16/06/2025.
//

import SwiftUI
import SlidingRuler

struct MetricUnitS: View {
    enum Gender {
        case man
        case woden
    }
    enum EditingField {
        case none, weightKg, age
    }
    @State private var selectionGenden: Gender = .man
    @State private var value: Double = .zero
    @State private var input = ""
    @State private var isShowDialog = false
    @State private var editingField: EditingField = .none
    @State private var age = 26
    @State private  var weightKg = 19.5
    @StateObject private var viewModel = UserViewModel()
    @EnvironmentObject var route: Router
    
    var body: some View {
        VStack {
            ScrollView {
                HStack {
                    //                    Button {
                    //                        selectionGenden = .man
                    //                    } label: {
                    //                        Image("man")
                    //                            .renderingMode(.template)
                    //                            .resizable()
                    //                            .scaledToFit()
                    //                            .frame(width: 40)
                    //                            .foregroundColor(selectionGenden == .man ? .blue : .gray)
                    //                    }
                    
                    ForEach(viewModel.people) { person in
                        Image(person.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200)
                    }
                    
                    //                    Button {
                    //                        selectionGenden = .woden
                    //                    } label: {
                    //                        Image("woden")
                    //                            .renderingMode(.template)
                    //                            .resizable()
                    //                            .scaledToFit()
                    //                            .frame(width: 40)
                    //                            .foregroundColor(selectionGenden == .woden ? .pink : .gray)
                    //                    }
                }
                
                Text(String(format: "Height(165cm) (%.1f cm)", value))
                    .foregroundStyle(Color.green)
                
                SlidingRuler (
                    value: $value,
                    in: 0...250,
                    step: 1,
                    snap: .fraction,
                    tick: .fraction
                )
                .padding()
                
                HStack(spacing: 20) {
                    stepperBox(title: "Weight(Kg)", value: $weightKg, field: .weightKg)
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
                let heightInMeters = value / 100
                let bmi = weightKg / (heightInMeters * heightInMeters)
                let minWeight = 18.5 * heightInMeters * heightInMeters
                let maxWeight = 24.9 * heightInMeters * heightInMeters
                let healthyRange = String(format: "%.1fkg - %.1fkg", minWeight, maxWeight)
                let resultModel = BmiResult(bmi: bmi, healthyWeightRange: healthyRange)
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
            viewModel.fetchPeople()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                if let person = viewModel.people.first {
                    value = person.heightCm
                    weightKg = person.weightKg
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
                            case .weightKg: weightKg = Double(value)
                            case .age: age = Int(value)
                            default: break
                            }
                        }
                        editingField = .none
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
    MetricUnitS()
}
