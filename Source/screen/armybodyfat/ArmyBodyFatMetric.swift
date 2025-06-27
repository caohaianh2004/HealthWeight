//
//  ArmyBodyFatMetric.swift
//  Health_Weight
//
//  Created by Boss on 27/06/2025.
//

import SwiftUI
import SlidingRuler

struct ArmyBodyFatMetric: View {
    enum EditingField {
        case none, weightkg, age, neck, waist, hip
    }
    @EnvironmentObject var route: Router
    @StateObject private var viewModel = UserViewModel()
    @State private var heightCm: Double = .zero
    @State private var editingField: EditingField = .none
    @State private var weightkg: Double = .zero
    @State private var age: Int = .zero
    @State private var neck: Double = 30.5
    @State private var waist: Double = 30.5
    @State private var hip: Double = 30.5
    @State private var gender = "man"
    @State private var input = ""
    @State private var isShowDialog = false
    
    var body: some View {
        ZStack {
            VStack {
                ScrollView {
                    ForEach(viewModel.people) { person in
                        Image(person.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200)
                    }
                    
                    Text(String(format: "Height (165cm) (%.1f cm)", heightCm))
                        .foregroundStyle(Color.green)
                        .bold()
                    
                    SlidingRuler(
                        value:  $heightCm,
                        in: 30...250,
                        snap: .fraction,
                        tick: .fraction
                    )
                    
                    VStack {
                        HStack {
                            stepperBox(title: "Weight(Kg)", value: $weightkg, field: .weightkg)
                                .padding(20)
                                .background(.gray.opacity(0.2))
                                .cornerRadius(12)
                            stepperBoxAge(title: "Age", value: $age, field: .age)
                                .padding(20)
                                .background(.gray.opacity(0.2))
                                .cornerRadius(12)
                        }
                        
                        HStack {
                            stepperBox(title: "Neck(Cm)", value: $neck, field: .neck)
                                .padding(20)
                                .background(.gray.opacity(0.2))
                                .cornerRadius(12)
                            stepperBox(title: "Waist(cm)", value: $waist, field: .waist)
                                .padding(20)
                                .background(.gray.opacity(0.2))
                                .cornerRadius(12)
                        }
                        
                        if gender == "woman" {
                            stepperBox(title: "Hip(cm)", value: $hip, field: .hip)
                                .padding(20)
                                .background(.gray.opacity(0.2))
                                .cornerRadius(12)
                        }
                    }
                }
                Spacer()
                buttonCalculate()
            }
            .onAppear {
                viewModel.fetchPeople()
                if let person = viewModel.people.first {
                    heightCm = person.heightCm
                    weightkg = person.weightKg
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
                            if let value = Double(input) {
                                switch editingField {
                                case .weightkg:
                                    weightkg = Double(value)
                                case .age:
                                    age = Int(value)
                                case .neck:
                                    neck = Double(value)
                                case .waist:
                                    waist = Double(value)
                                case .hip:
                                    hip = Double(value)
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
            let result: Double
                  if gender == "man" {
                      result = armyBodyFatMaleCM(waist: waist, neck: neck, height: heightCm)
                  } else {
                      result = armyBodyFatFemaleCM(waist: waist, hip: hip, neck: neck, height: heightCm)
                  }

            route.navigateTo(.resultarmbody(resultarm: result))
        } label: {
            Text(localizedkey: "abc_calculate")
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.green)
                .cornerRadius(13)
                .foregroundColor(.white)
                .bold()
        }
        .padding()
    }
    
    func armyBodyFatMaleCM(waist: Double, neck: Double, height: Double) -> Double {
        return 86.010 * log10(waist - neck) - 70.041 * log10(height) + 36.76
    }

    func armyBodyFatFemaleCM(waist: Double, hip: Double, neck: Double, height: Double) -> Double {
        return 163.205 * log10(waist + hip - neck) - 97.684 * log10(height) - 78.387
    }

    private func stepperBox(title: String, value: Binding<Double>, field: EditingField) -> some View {
        VStack {
            Text(title).bold()
            HStack {
                stepperButton("-", action: { value.wrappedValue -= 1 })
                Text(String(format: "%.1f", value.wrappedValue))
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
    ArmyBodyFatMetric()
}
