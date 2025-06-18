//
//  ViewMetric.swift
//  Health_Weight
//
//  Created by Boss on 18/06/2025.
//

import SwiftUI
import SlidingRuler

struct ViewMetric: View {
    enum EditingField {
        case none, weightkg, age
    }
    @EnvironmentObject var route: Router
    @StateObject private var viewModel = UserViewModel()
    @State private var heightcm: Double = 175.6
    @State private var weightKg: Double = 13.6
    @State private var age: Int = 24
    @State private var editingField: EditingField = .none
    @State private var input: String = ""
    @State private var isShowDialog: Bool = false
    @State private var isShowList = false
    @State private var seletedtext = "Basal Metabolic Rate (BMR)"
    @State private var isShowMore = false
    
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
                        .font(.system(size: 18))
                        .bold()
                    
                    SlidingRuler (
                        value: $heightcm,
                        in: 30...280,
                        step: 1,
                        snap: .fraction,
                        tick: .fraction
                    )
                    .padding()
                    
                    HStack(spacing: 20) {
                        stepperBox(title: "Weight(Kg)", value: $weightKg, field: .weightkg)
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
             
            if isShowList {
                ChooseList(isPresentedtext: $seletedtext, iSShowList: $isShowList)
            }
            
            if isShowMore {
                MoreList(isShowMore: $isShowMore)
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
    
    func buttonCalculate() -> some View {
        VStack {
            Button {
                
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
    ViewMetric()
}
