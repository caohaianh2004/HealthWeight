//
//  leanboyUS.swift
//  Health_Weight
//
//  Created by Boss on 25/06/2025.
//

import SwiftUI
import SlidingRuler

struct leanboyUS: View {
    enum EditingField {
        case none, weightpound, age
    }
    @EnvironmentObject var route: Router
    @StateObject var viewModel = UserViewModel()
    @State private var heightft: Double = .zero
    @State private var heightin: Double = .zero
    @State private var weightpound: Double = .zero
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
                Text(String(format: "Height (%.1f ft %.1f in)", heightft, heightin))
                    .foregroundStyle(Color.green)
                
                SlidingRuler(
                    value: $heightft,
                    in: 1...7,
                    snap: .fraction,
                    tick: .fraction
                )
                .padding(10)
                
                Text(localizedkey: "abc_ft")
                    .font(.system(size: 13))
                
                SlidingRuler(
                    value: $heightin,
                    in: 0...12,
                    snap: .fraction,
                    tick: .fraction
                )
                .padding(10)
                
                Text(localizedkey: "abc_in")
                    .font(.system(size: 13))
                
                HStack {
                    stepperBox(title: "Weight(pound)", value: $weightpound, field: .weightpound)
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
                    heightft = person.heightFt
                    heightin = person.heightln
                    weightpound = person.weightLb
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
                                case .weightpound:
                                    weightpound = Double(value)
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
            let heightInTotal = heightft * 12 + heightin

                  let boer = lbmBoerLbs(weightLb: weightpound, heightIn: heightInTotal, gender: gender)
                  let james = lbmJamesLbs(weightLb: weightpound, heightIn: heightInTotal, gender: gender)
                  let hume = lbmHumeLbs(weightLb: weightpound, heightIn: heightInTotal, gender: gender)

                  let boerFat = 100 - (boer / weightpound * 100)
                  let jamesFat = 100 - (james / weightpound * 100)
                  let humeFat = 100 - (hume / weightpound * 100)

                  route.navigateTo(.leanbodyresult(
                      boerlean: boer,
                      boerbody: boerFat,
                      jameslean: james,
                      jmmesbody: jamesFat,
                      humelean: hume,
                      humebody: humeFat,
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
    
    func lbmBoerLbs(weightLb: Double, heightIn: Double, gender: String) -> Double {
        if gender == "man" {
            return 0.407 * weightLb + 0.267 * heightIn - 19.2
        } else {
            return 0.252 * weightLb + 0.473 * heightIn - 48.3
        }
    }

    func lbmJamesLbs(weightLb: Double, heightIn: Double, gender: String) -> Double {
        if gender == "man" {
            return 1.1 * weightLb - 128 * pow(weightLb, 2) / pow(heightIn, 2)
        } else {
            return 1.07 * weightLb - 148 * pow(weightLb, 2) / pow(heightIn, 2)
        }
    }

    func lbmHumeLbs(weightLb: Double, heightIn: Double, gender: String) -> Double {
        if gender == "man" {
            return 0.32810 * weightLb + 0.33929 * heightIn - 29.5336
        } else {
            return 0.29569 * weightLb + 0.41813 * heightIn - 43.2933
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
    leanboyUS()
}
