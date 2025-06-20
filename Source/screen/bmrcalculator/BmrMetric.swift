//
//  BmrMetric.swift
//  Health_Weight
//
//  Created by Boss on 20/06/2025.
//

import SwiftUI
import SlidingRuler

struct BmrMetric: View {
    @EnvironmentObject var route: Router
    enum EditingField {
        case none, weightkg, age
    }
    @State private var heightcm = 175.0
    @StateObject private var viewModel = UserViewModel()
    @State private var isShowDialog = false
    @State private var editingField: EditingField = .none
    @State private var input = ""
    @State private var weightKg = 70.5
    @State private var age = 35
    @State private var isShowMore = false
    
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
                    
                    Text(String(format: "Height(165cm) (%.1f cm)", heightcm))
                        .foregroundStyle(Color.green)
                    
                    SlidingRuler(
                        value: $heightcm,
                        in: 30...250,
                        step: 1,
                        snap: .fraction,
                        tick: .fraction
                    )
                    .padding(10)
                    
                    HStack {
                        stepperBox(title: "Weight(Kg)", value: $weightKg, field: .weightkg)
                            .padding(20)
                            .background(.gray.opacity(0.2))
                            .cornerRadius(12)
                        stepperBoxAge(title: "Age", value: $age, field: .age)
                            .padding(20)
                            .background(.gray.opacity(0.2))
                            .cornerRadius(12)
                    }
                    buttonMore()
                }
                
                buttonCalculate()
                
                Spacer()
            }
            .onAppear {
                viewModel.fetchPeople()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    if let person = viewModel.people.first {
                        heightcm = person.heightCm
                        weightKg = person.weightKg
                        age = person.age
                    }
                }
            }
            ChooseWeight(isShowDialog: $isShowDialog, input: $input)
                .onChange(of: isShowDialog) { newvalue in
                    if !newvalue {
                        DispatchQueue.main.async {
                            if let value = Double(input){
                                switch editingField {
                                case .weightkg:
                                    weightKg = Double(value)
                                case .age:
                                    age = Int(value)
                                default: break
                                }
                            }
                            editingField = .none
                        }
                    }
                }
            if isShowMore {
                MoreList(isShowMore: $isShowMore, selectedUnit: $selectedUnit, selectedFormula: $selectedFormula, bodyFat: $bodyFatPercentage)
            }
        }
    }
    
    func buttonCalculate() -> some View {
        VStack {
            Button {
                
            } label: {
                Text(localizedkey: "abc_calculate")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .foregroundStyle(Color.white)
                    .cornerRadius(12)
                    .padding()
            }
        }
    }
    
    func buttonMore() -> some View {
        HStack {
            Button {
                isShowMore = true
            } label: {
                Image(systemName: "plus.circle")
                    .font(.title2)
                    .foregroundColor(.black)
                Text(localizedkey: "abc_more")
                    .foregroundStyle(Color.black)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
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
}

#Preview {
    BmrMetric()
}
