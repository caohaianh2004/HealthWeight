//
//  IdealWeight.swift
//  Health_Weight
//
//  Created by Boss on 24/06/2025.
//

import SwiftUI
import SlidingRuler

struct IdealWeightUS: View {
    enum EditingField {
        case none, age
    }
    @EnvironmentObject var route: Router
    @StateObject private var viewModel = UserViewModel()
    @State private var heightft: Double = .zero
    @State private var heightin: Double = .zero
    @State private var age: Int = .zero
    @State private var editingField: EditingField = .none
    @State private var isShowDialog = false
    @State private var input = ""
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
                
                Text(String(format: "Height (%.1f ft %.1f in)", heightft, heightin))
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
                    .font(.system(size: 13))
                
                SlidingRuler (
                    value: $heightin ,
                    in: 0...12,
                    snap: .fraction,
                    tick: .fraction
                )
                .padding(10)
                
                Text(localizedkey: "abc_in")
                    .font(.system(size: 13))
                
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
                    heightft = person.heightFt
                    heightin = person.heightln
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
            let totalInches = heightft * 12 + heightin
            let over5Feet = max(0, totalInches - 60) // 60 inches = 5 feet

            // Công thức tính theo giới tính
            let robinson: Double
            let miller: Double
            let devine: Double
            let hamwi: Double

            if gender == "man" {
                robinson = 114 + 1.5 * over5Feet
                miller   = 123.5 + 1.1 * over5Feet
                devine   = 110 + 5.0 * over5Feet
                hamwi    = 106 + 6.0 * over5Feet
            } else {
                robinson = 108 + 1.5 * over5Feet
                miller   = 117.5 + 1.1 * over5Feet
                devine   = 100 + 5.0 * over5Feet
                hamwi    = 100 + 5.0 * over5Feet
            }

            // Healthy BMI range
            let heightMeters = totalInches * 0.0254
            let minHealthy = 18.5 * pow(heightMeters, 2) * 2.20462
            let maxHealthy = 24.9 * pow(heightMeters, 2) * 2.20462

            // Điều hướng sang màn hình kết quả
            route.navigateTo(.idealWeightResult(
                robinson: robinson,
                miller: miller,
                devine: devine,
                hamwi: hamwi,
                healthyMin: minHealthy,
                healthyMax: maxHealthy,
                unit: "lbs"
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
    IdealWeightUS()
}
