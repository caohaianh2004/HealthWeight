//
//  BodyMetric.swift
//  Health_Weight
//
//  Created by Boss on 23/06/2025.
//

import SwiftUI
import SlidingRuler

struct BodyMetric: View {
    enum EditingField {
        case none, weightkg, age, neck, waist, hip
    }
    @EnvironmentObject var route: Router
    @StateObject private var viewModel = UserViewModel()
    @State private var heightCm: Double = .zero
    @State private var input = ""
    @State private var isShowDialog = false
    @State private var editingField: EditingField = .none
    @State private var weightkg: Double = .zero
    @State private var age: Int = .zero
    @State private var neck: Double = 30.5
    @State private var waist: Double = 30.5
    @State private var hip: Double = 30.5
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
                    Text(String(format: "Height(165cm) (%.1f cm)", heightCm))
                        .foregroundStyle(Color.green)
                        .bold()
                    
                    SlidingRuler(
                        value: $heightCm,
                        in: 30...280,
                        step: 1,
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
                
                buttonCalculate()
                Spacer()
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
            // Tính phần trăm mỡ
            let result: Double
            if gender == "woman" {
                result = calculateBoyFat(
                    gender: "woman",
                    heightCm: heightCm,
                    nekCm: neck,
                    waistCm: waist,
                    hipCm: hip
                )
            } else {
                result = calculateBoyFat(
                    gender: "man",
                    heightCm: heightCm,
                    nekCm: neck,
                    waistCm: waist
                )
            }

            // Tính các thông số khối lượng
            let fatMass = weightkg * result / 100
            let leanMass = weightkg - fatMass
            let idealFat = idealBodyFat(for: age, gender: gender)
            let idealFatMass = weightkg * idealFat / 100
            let fatToLose = max(fatMass - idealFatMass, 0)

            // Tính BMI và mỡ theo công thức BMI
            let heightInMeters = heightCm / 100
            let bmi = weightkg / (heightInMeters * heightInMeters)
            
            let bmiMethodFat: Double
            if gender == "man" {
                bmiMethodFat = 1.20 * bmi + 0.23 * Double(age) - 16.2
            } else {
                bmiMethodFat = 1.20 * bmi + 0.23 * Double(age) - 5.4
            }

            // Loại mỡ
            let category = bodyFatCategory(for: result, gender: gender)

            // Chuyển màn hình
            route.navigateTo(.boyfatresult(
                bodyFatPercentage: result,
                fatMass: fatMass,
                leanMass: leanMass,
                idealFatPercent: idealFat,
                fatToLose: fatToLose,
                bmiMethodFat: bmiMethodFat,
                category: category,
                gender: gender,
                unit: "kg"
            ))

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
    }


    
    func calculateBoyFat(gender: String, heightCm: Double, nekCm: Double, waistCm: Double, hipCm: Double? = nil) -> Double {
        if heightCm <= 0 {
            return 0
        }

        if gender == "man" {
            let diff = waistCm - nekCm
            guard diff > 0 else { return 0 }
            return 86.010 * log10(diff) - 70.041 * log10(heightCm) + 36.76
        } else {
            guard let hip = hipCm else { return 0 }
            let sum = waistCm + hip - nekCm
            guard sum > 0 else { return 0 }
            return 163.205 * log10(sum) - 97.684 * log10(heightCm) - 78.387
        }
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
    
    func idealBodyFat(for age: Int, gender: String) -> Double {
        switch age {
        case 20..<30: return gender == "man" ? 16.5 : 22.7
        case 30..<40: return gender == "man" ? 18.9 : 24.5
        case 40..<50: return gender == "man" ? 21.5 : 27.1
        case 50..<60: return gender == "man" ? 22.7 : 29.7
        default:      return gender == "man" ? 23.2 : 30.9
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
}

#Preview {
    BodyMetric()
}


struct BodyFatData: Hashable {
    let percentage: Double
    let fatMass: Double
    let leanMass: Double
    let idealPercentage: Double
    let idealFatMass: Double
    let fatToLose: Double
    let bmiFatMass: Double
    let category: String
}
