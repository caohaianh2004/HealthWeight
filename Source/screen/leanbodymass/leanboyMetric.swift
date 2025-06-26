//
//  leanboyMetric.swift
//  Health_Weight
//
//  Created by Boss on 25/06/2025.
//

import SwiftUI
import SlidingRuler

struct leanboyMetric: View {
    enum EditingField {
        case none, weightkg, age
    }
    @EnvironmentObject var route: Router
    @StateObject var viewModel = UserViewModel()
    @State private var heightcm: Double = .zero
    @State private var weightkg: Double = .zero
    @State private var age: Int = .zero
    @State private var input = ""
    @State private var isShowDialog = false
    @State private var gender = "man"
    @State private var editingField: EditingField = .none
    
    var body: some View {
        ZStack {
            VStack {
                ForEach(viewModel.people) { person in
                    Image(person.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200)
                }
                Text(String(format: "Height(165 cm) (%.1f cm)", heightcm))
                    .foregroundStyle(Color.green)
                    .bold()
                
                SlidingRuler(
                    value: $heightcm,
                    in: 30...250,
                    snap: .fraction,
                    tick: .fraction
                )
                .padding(10)
                HStack {
                    stepperBox(title: "Weight(kg)", value: $weightkg, field: .weightkg)
                        .padding(20)
                        .background(.gray.opacity(0.2))
                        .cornerRadius(12)
                    
                    stepperBoxAge(title: "Age", value: $age, field: .age)
                        .padding(20)
                        .background(.gray.opacity(0.2))
                        .cornerRadius(12)
                }
                
                Spacer()
               buttonCalculate()
            }
            .onAppear {
                viewModel.fetchPeople()
                if let person = viewModel.people.first {
                    heightcm = person.heightCm
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
            let boer = lbmBoer(weightKg: weightkg, heightCm: heightcm, gender: gender)
            let james = lbmJames(weightKg: weightkg, heightCm: heightcm, gender: gender)
            let hume = lbmHume(weightKg: weightkg, heightCm: heightcm, gender: gender)

            let boerFat = 100 - (boer / weightkg * 100)
            let jamesFat = 100 - (james / weightkg * 100)
            let humeFat = 100 - (hume / weightkg * 100)

            route.navigateTo(.leanbodyresult(
                boerlean: boer,
                boerbody: boerFat,
                jameslean: james,
                jmmesbody: jamesFat,
                humelean: hume,
                humebody: humeFat,
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

    
    func lbmBoer(weightKg: Double, heightCm: Double, gender: String) -> Double {
        if gender == "man" {
            return 0.407 * weightKg + 0.267 * heightCm - 19.2
        } else {
            return 0.252 * weightKg + 0.473 * heightCm - 48.3
        }
    }

    func lbmJames(weightKg: Double, heightCm: Double, gender: String) -> Double {
        if gender == "man" {
            return 1.1 * weightKg - 128 * pow(weightKg, 2) / pow(heightCm, 2)
        } else {
            return 1.07 * weightKg - 148 * pow(weightKg, 2) / pow(heightCm, 2)
        }
    }

    func lbmHume(weightKg: Double, heightCm: Double, gender: String) -> Double {
        if gender == "man" {
            return 0.32810 * weightKg + 0.33929 * heightCm - 29.5336
        } else {
            return 0.29569 * weightKg + 0.41813 * heightCm - 43.2933
        }
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
    leanboyMetric()
}
