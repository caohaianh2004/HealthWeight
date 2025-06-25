//
//  BodyUS.swift
//  Health_Weight
//
//  Created by Boss on 23/06/2025.
//

import SwiftUI
import SlidingRuler

struct BodyUS: View {
    enum EditingField {
        case none, Weightpound, age, neckft, neckin, waistft, waistin, hipft, hipin
    }
    @EnvironmentObject var route: Router
    @State private var heightft: Double = .zero
    @State private var heightin: Double = .zero
    @State private var weightpoung = 163.5
    @State private var age: Int = .zero
    @State private var neckft: Int = 1
    @State private var neckin: Double = 0
    @State private var waistft: Int = 1
    @State private var waistin: Double = 0
    @State private var hipft: Int = 1
    @State private var hipin: Double = 0
    @State private var isShowDialog = false
    @StateObject var viewModel = UserViewModel()
    @State private var input = ""
    @State private var editingField: EditingField = .none
    @State private var gender = "man"
    @State private var alerText = ""
    @State private var showAlert = false
    
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
                                case .neckft, .waistft, .hipft:
                                    if value < 1 || value > 7 {
                                        alerText = "fr value must be from 1 to 7"
                                        showAlert = true
                                    } else {
                                        setIntField(field: editingField, value: Int(value))
                                    }
                                case .neckin, .waistin, .hipin:
                                    if value < 0 || value > 12 {
                                        alerText = "The printed value must be between 0 and 12."
                                        showAlert = true
                                    } else {
                                        setDoubleField(field: editingField, value: value)
                                    }
                                default: break
                                }
                            }
                            editingField = .none
                        }
                    }
                }
        } 
        .alert(isPresented: $showAlert) {
            Alert(title: Text("🚨 Input error"), message: Text(alerText), dismissButton: .default(Text("OK")))
        }
    }
    
    func buttonCalculate() -> some View {
        Button {
            let result = calculateBodyFatUS(
                heightFt: heightft,
                heightIn: heightin,
                neckFt: neckft,
                neckIn: neckin,
                waistFt: waistft,
                waistIn: waistin,
                hipFt: gender == "woman" ? hipft : nil,
                hipIn: gender == "woman" ? hipin : nil,
                gender: gender
            )

            let fatMass = weightpoung * result / 100
            let leanMass = weightpoung - fatMass
            let idealFat = idealBodyFat(for: age, gender: gender)
            let fatToLose = max(fatMass - (weightpoung * idealFat / 100), 0)
            
            // BMI (dùng pound + inch)
            let heightInInches = heightft * 12 + heightin
            let bmi = (weightpoung / pow(heightInInches, 2)) * 703
            
            let bmiMethodFat = gender == "man"
                ? 1.20 * bmi + 0.23 * Double(age) - 16.2
                : 1.20 * bmi + 0.23 * Double(age) - 5.4
            
            let category = bodyFatCategory(for: result, gender: gender)

            route.navigateTo(.boyfatresult(
                bodyFatPercentage: result,
                fatMass: fatMass,
                leanMass: leanMass,
                idealFatPercent: idealFat,
                fatToLose: fatToLose,
                bmiMethodFat: bmiMethodFat,
                category: category,
                gender: gender,
                unit: "lbs"
            ))
            
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

    
    func calculateBodyFatUS(heightFt: Double, heightIn: Double, neckFt: Int, neckIn: Double, waistFt: Int, waistIn: Double, hipFt: Int?, hipIn: Double?, gender: String) -> Double {
        let height = heightFt * 12 + heightIn
        let neck = Double(neckFt) * 12 + neckIn
        let waist = Double(waistFt) * 12 + waistIn
        let hip = gender == "woman" ? Double(hipFt ?? 0) * 12 + (hipIn ?? 0) : 0.0

        guard height > 0, neck > 0, waist > 0 else {
            return 0
        }

        if gender == "man" {
            let numerator = waist - neck
            guard numerator > 0 else { return 0 }
            return 86.010 * log10(numerator) - 70.041 * log10(height) + 36.76
        } else {
            let numerator = waist + hip - neck
            guard numerator > 0 else { return 0 }
            return 163.205 * log10(numerator) - 97.684 * log10(height) - 78.387
        }
    }

    func idealBodyFat(for age: Int, gender: String) -> Double {
        switch gender {
        case "man":
            switch age {
            case 20...29: return 14.0
            case 30...39: return 17.0
            case 40...49: return 19.0
            case 50...59: return 22.0
            default: return 20.0 // nếu ngoài khoảng
            }
        case "woman":
            switch age {
            case 20...29: return 20.0
            case 30...39: return 21.0
            case 40...49: return 23.0
            case 50...59: return 24.0
            default: return 22.0
            }
        default:
            return 18.0
        }
    }
    

    func bodyFatCategory(for value: Double, gender: String) -> String {
        let ranges: [(Double, String)] = gender == "man"
        ? [(2, "Essential Fat"), (6, "Athletes"), (14, "Fitness"), (18, "Average"), (25, "Obese")]
            : [(10, "Essential Fat"), (14, "Athletes"), (21, "Fitness"), (25, "Average"), (32, "Obese")]

        // Nếu nhỏ hơn mức thấp nhất → trả về "Less than Essential Fat"
        if value < ranges.first!.0 {
            return "Less than Essential Fat"
        }

        // Duyệt các mốc để xác định phân loại
        for (threshold, label) in ranges.reversed() {
            if value >= threshold {
                return label
            }
        }

        return "Unknown"
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
    
    private func stepperBoxft(title: String, valueft: Binding<Int>, valuein: Binding<Double>, field: EditingField, fieldin: EditingField) -> some View {
        VStack {
            Text(title).bold()
            HStack {
                Text("\(valueft.wrappedValue)")
                    .padding(5)
                    .font(.system(size: 18))
                    .frame(width: 30)
                    .background(Color.white)
                    .cornerRadius(8)
                    .onTapGesture {
                        input = "\(valueft.wrappedValue)"
                        editingField = field
                        isShowDialog = true
                    }
                
                Text("ft")
                
                Text(String(format: "%.1f", valuein.wrappedValue))
                    .padding(5)
                    .font(.system(size: 18))
                    .frame(width: 40)
                    .background(Color.white)
                    .cornerRadius(8)
                    .onTapGesture {
                        input = "\(valuein.wrappedValue)"
                        editingField = fieldin
                        isShowDialog = true
                    }
                
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

    private func setDoubleField(field: EditingField, value: Double) {
        switch field {
        case .neckin: neckin = value
        case .waistin: waistin = value
        case .hipin: hipin = value
        default: break
        }
    }

}

#Preview {
    BodyUS()
}
