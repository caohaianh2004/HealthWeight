//
//  ViewUs.swift
//  Health_Weight
//
//  Created by Boss on 18/06/2025.
//

import SwiftUI
import SlidingRuler

struct ViewUs: View {
    enum EditingField {
        case none, weightPound, age
    }
    @State private var editingField: EditingField = .none
    @EnvironmentObject var route: Router
    @StateObject private var viewModel = UserViewModel()
    @State private var heightft: Double = .zero
    @State private var heightln: Double = .zero
    @State private var isShowDialog = false
    @State private var input = ""
    @State private var weightpound = 12.5
    @State private var age = 25
    @State private var showList = false
    @State private var isShowMore = false
    @State private var isShowList = false
    @State private var seletedtext = "Basal Metabolic Rate (BMR)"
    
    @State private var selectedUnit: String = "Calories" // or Kilojoules
    @State private var selectedFormula: String = "Mifflin St Joer"
    @State private var selectedActivityFactor: Double = 1.2
    @State private var bodyFatPercentage: Double = 0.2 // giả định ban đầu 20%
    
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
                    Text(String(format: "Height (%.1f ft %.1f in)", heightft, heightln))
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
                    
                    SlidingRuler (
                        value: $heightln,
                        in: 0...12,
                        step: 1,
                        snap: .fraction,
                        tick: .fraction
                    )
                    .padding(10)
                    
                    Text(localizedkey: "abc_in")
                    
                    HStack(spacing: 20) {
                        stepperBox(title: "Weight(pound)", value: $weightpound, field: .weightPound)
                            .padding(20)
                            .background(.gray.opacity(0.2))
                            .cornerRadius(12)
                        
                        stepperBoxAge(title: "Age", value: $age, field: .age)
                            .padding(20)
                            .background(.gray.opacity(0.2))
                            .cornerRadius(12)
                    }
                    
                    VStack {
                        Text(localizedkey: "abc_activity")
                            .font(.title3)
                        
                        buttonBMR()
                        
                        buttonMore()
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(5)
                    
                }
                
               buttonCalculate()
            }

            .onAppear {
                viewModel.fetchPeople()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    if let person = viewModel.people.first {
                        heightft = person.heightFt
                        heightln = person.heightln
                        weightpound = person.weightLb
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
                                case .weightPound: weightpound = Double(value)
                                case .age: age = Int(value)
                                default: break
                                }
                            }
                            editingField = .none
                        }
                    }
                }
            
            if isShowList {
                ChooseList(isPresentedtext: $seletedtext, iSShowList: $isShowList, activityFactor: $selectedActivityFactor)
            }
            
            if isShowMore {
                MoreList(isShowMore: $isShowMore, selectedUnit: $selectedUnit, selectedFormula: $selectedFormula, bodyFat: $bodyFatPercentage)
            }
        }
    }
    
    func buttonBMR() -> some View {
        ZStack {
            Button {
                isShowList = true
            } label: {
                HStack {
                    Text(seletedtext)
                        .foregroundStyle(Color.black)
                    Spacer()
                    Image(systemName: "arrowtriangle.down.fill")
                        .foregroundColor(.black)
                }
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(12)
                
            }
            .padding()
        }
    }
    
    func buttonMore() -> some View {
        ZStack{
            Button {
                isShowMore = true
            } label: {
                HStack {
                    Image(systemName: "plus.circle")
                        .font(.title)
                        .foregroundColor(.black)
                    Text(localizedkey: "abc_more")
                        .foregroundStyle(Color.black)
                        .bold()
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
    
    func buttonCalculate() -> some View {
          VStack {
              Button {
                  let bmr = calculateBMR(
                      formula: selectedFormula,
                      gender: "male",
                      weight: weightpound,
                      heightft: heightft,
                      heightin: heightln,
                      age: age,
                      bodyFat: bodyFatPercentage,
                      unit: selectedUnit
                  )
                  let tdee = bmr * selectedActivityFactor
                  
                  if seletedtext == "Basal Metabolic Rate (BMR)" {
                      route.navigateTo(.result(bmr: bmr, unit: seletedtext))
                  } else {
                      route.navigateTo(.calorieresult(bmr: bmr, tdee: tdee, unit: selectedUnit))
                  }

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
      }
    
    func calculateBMR(
        formula: String,
        gender: String,
        weight: Double,
        heightft: Double,
        heightin: Double,
        age: Int,
        bodyFat: Double,
        unit: String
    ) -> Double {
        // Chuyển từ feet + inch sang cm
        let heightCm = (heightft * 30.48) + (heightin * 2.54)
        
        var bmr: Double = 0

        switch formula {
        case "Mifflin St Joer":
            bmr = 10 * weight + 6.25 * heightCm - 5 * Double(age) + (gender == "male" ? 5 : -161)
            
        case "Revised Harris-Benedict":
            bmr = gender == "male"
                ? 13.397 * weight + 4.799 * heightCm - 5.677 * Double(age) + 88.362
                : 9.247 * weight + 3.098 * heightCm - 4.330 * Double(age) + 447.593
            
        case "Katch-McArdle":
            let leanMass = (1 - bodyFat) * weight
            bmr = 370 + 21.6 * leanMass
            
        default:
            break
        }

        // Đổi sang kilojoules nếu được chọn
        if unit == "Kilojoules" {
            return bmr * 4.184
        }
        
        return bmr
    }

}

#Preview {
    ViewUs()
}
