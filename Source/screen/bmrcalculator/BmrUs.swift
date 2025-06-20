//
//  BmrUs.swift
//  Health_Weight
//
//  Created by Boss on 20/06/2025.
//

import SwiftUI
import SlidingRuler

struct BmrUs: View {
    enum EditingField {
            case none, weightpound, age
        }
    @EnvironmentObject var route: Router
    @StateObject private var viewMode = UserViewModel()
    @State private var heightft: Double = .zero
    @State private var heightin: Double = .zero
    @State private var editingField: EditingField = .none
    @State private var isShowDialog = false
    @State private var input = ""
    @State private var weightpound = 200.8
    @State private var age = 32
    @State private var isShowMore = false
    
    @State private var selectedUnit: String = "Calories" // or Kilojoules
    @State private var selectedFormula: String = "Mifflin St Joer"
    @State private var selectedActivityFactor: Double = 1.2
    @State private var bodyFatPercentage: Double = 0.2 // giả định ban đầu 20%
    
    var body: some View {
        ZStack {
            VStack {
                ScrollView {
                    ForEach(viewMode.people) { person in
                        Image(person.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200)
                    }
                    Text(String(format: "Height(%.1f ft %.1f in )", heightft, heightin))
                    
                    SlidingRuler (
                        value: $heightft,
                        in: 1...7,
                        step: 1,
                        snap: .fraction,
                        tick: .fraction
                    )
                    .padding(10)
                    
                    Text(localizedkey: "abc_ft")
                        .font(.system(size: 15))
                    
                    SlidingRuler (
                        value: $heightin,
                        in: 0...12,
                        step: 1,
                        snap: .fraction,
                        tick: .fraction
                    )
                    .padding(10)
                    
                    Text(localizedkey: "abc_in")
                        .font(.system(size: 15))
                    
                    HStack(spacing: 20) {
                        stepperBox(title: "Weight(pound)", value: $weightpound, field: .weightpound)
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
                buttonResult()
            }
            .onAppear {
                viewMode.fetchPeople()
                if let person = viewMode.people.first {
                    heightft = person.heightFt
                    heightin = person.heightln
                    weightpound = person.weightLb
                    age = person.age
                }
            }
            
            ChooseWeight(isShowDialog: $isShowDialog, input: $input)
                .onChange(of: isShowDialog) { newValue in
                    if !newValue {
                        DispatchQueue.main.async {
                            if let value = Double(input) {
                                switch editingField {
                                case .weightpound: weightpound = Double(value)
                                case .age: age = Int(value)
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
    
    func buttonResult() -> some View {
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
    
    func buttonMore() -> some View {
            Button {
                isShowMore = true
            } label: {
                HStack {
                    Image(systemName: "plus.circle")
                        .font(.title)
                        .foregroundColor(.black)
                    Text(localizedkey: "abc_more")
                        .foregroundColor(.black)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
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
    
}

#Preview {
    BmrUs()
}
