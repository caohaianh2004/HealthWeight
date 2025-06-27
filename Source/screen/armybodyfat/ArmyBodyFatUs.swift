//
//  ArmyBodyFatUs.swift
//  Health_Weight
//
//  Created by Boss on 27/06/2025.
//

import SwiftUI
import SlidingRuler

struct ArmyBodyFatUs: View {
    enum EditingField {
        case none, Weightpound, age, neckft, neckin, waistft, waistin, hipft, hipin
    }
    @EnvironmentObject var route: Router
    @State private var heightft: Double = .zero
    @State private var heightin: Double = .zero
    @State private var weightpoung: Double = .zero
    @State private var age: Int = .zero
    @State private var neckft: Int = 1
    @State private var neckin: Int = 8
    @State private var waistft: Int = 3
    @State private var waistin: Int = 2
    @State private var hipft: Int = 2
    @State private var hipin: Int = 7
    @State private var isShowDialog = false
    @StateObject var viewModel = UserViewModel()
    @State private var input = ""
    @State private var editingField: EditingField = .none
    @State private var gender = "man"
    
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
                    Text(String(format: "Height(%.1f ft %.1f in)", heightft, heightin))
                        .foregroundStyle(Color.green)
                    
                    SlidingRuler (
                        value: $heightft,
                        in: 1...7,
                        step: 1,
                        snap: .fraction,
                        tick: .fraction
                    )
                    .padding(10)
                    
                    Text(localizedkey: "abc_ft")
                        .font(.system(size: 13))
                    
                    SlidingRuler (
                        value: $heightin,
                        in: 0...12,
                        snap: .fraction,
                        tick: .fraction
                    )
                    .padding(10)
                    
                    Text(localizedkey: "abc_in")
                        .font(.system(size: 13))
                    
                    VStack {
                        HStack {
                            stepperBox(title: "Weight(pound)", value: $weightpoung, field: .Weightpound)
                                .padding(20)
                                .background(Color.gray.opacity(0.3))
                                .cornerRadius(12)
                            
                            stepperBoxAge(title: "Age", value: $age, field: .age)
                                .padding(20)
                                .background(Color.gray.opacity(0.3))
                                .cornerRadius(12)
                        }
                        
                        HStack {
                            stepperBoxft(title: "Neck(ft)", valueft: $neckft, valuein: $neckin, field: .neckft, fieldin: .neckin)
                                .frame(width: 135)
                                .padding(20)
                                .background(Color.gray.opacity(0.3))
                                .cornerRadius(12)
                            
                            stepperBoxft(title: "Waist(ft)", valueft: $waistft, valuein: $waistin, field: .waistft, fieldin: .waistin)
                                .frame(width: 135)
                                .padding(20)
                                .background(Color.gray.opacity(0.3))
                                .cornerRadius(12)
                        }
                        .padding()
                        
                        if gender == "woman" {
                            stepperBoxft(title: "Hip(ft)", valueft: $hipft, valuein: $hipin, field: .hipft, fieldin: .hipin)
                                .padding(20)
                                .background(Color.gray.opacity(0.3))
                                .cornerRadius(12)
                        }
                    }
                }
                buttonCalculate()
                Spacer()
            }
            .onAppear {
                viewModel.fetchPeople()
                if let person = viewModel.people.first {
                    heightft = person.heightFt
                    heightin =  person.heightln
                    weightpoung = person.weightLb
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
                                case .Weightpound:
                                    weightpoung = Double(value)
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
            // Chuyển đổi chiều cao, neck, waist, hip sang cm
            let heightCm = heightft * 30.48 + heightin * 2.54
            let neckCm = Double(neckft) * 30.48 + Double(neckin) * 2.54
            let waistCm = Double(waistft) * 30.48 + Double(waistin) * 2.54
            let hipCm = Double(hipft) * 30.48 + Double(hipin) * 2.54

            // Tránh log10(âm số hoặc 0)
            guard waistCm > neckCm, heightCm > 0 else { return }

            // Tính phần trăm mỡ
            var bodyFatPercent: Double = 0
            if gender == "man" {
                bodyFatPercent = armyBodyFatMaleCM(waist: waistCm, neck: neckCm, height: heightCm)
            } else {
                bodyFatPercent = armyBodyFatFemaleCM(waist: waistCm, hip: hipCm, neck: neckCm, height: heightCm)
            }

            // Điều hướng sang màn hình kết quả
            route.navigateTo(.resultarmbody(resultarm: bodyFatPercent))

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
    
    private func stepperBoxft(title: String, valueft: Binding<Int>, valuein: Binding<Int>, field: EditingField, fieldin: EditingField) -> some View {
        VStack {
            Text(title).bold()
            HStack {
                Text("\(valueft.wrappedValue)")
                    .padding(5)
                    .font(.system(size: 18))
                    .frame(width: 30)
                    .background(Color.white)
                    .cornerRadius(8)

                
                Text("ft")
                
                Text( "\(valuein.wrappedValue)")
                    .padding(5)
                    .font(.system(size: 18))
                    .frame(width: 40)
                    .background(Color.white)
                    .cornerRadius(8)
  
                
                Text("in")
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
    
    private func setIntField(field: EditingField, value: Int) {
        switch field {
        case .neckft: neckft = value
        case .waistft: waistft = value
        case .hipft: hipft = value
        default: break
        }
    }

    private func setDoubleField(field: EditingField, value: Int) {
        switch field {
        case .neckin: neckin = value
        case .waistin: waistin = value
        case .hipin: hipin = value
        default: break
        }
    }
}

#Preview {
    ArmyBodyFatUs()
}
