//
//  UsUnits.swift
//  Health_Weight
//
//  Created by Boss on 04/06/2025.
//

import SwiftUI
import SlidingRuler

struct UsUnits: View {
    
    enum EditingField {
        case none, weightlb, age, goal
    }
    @Binding var gender: Gender
    @Binding var height: Int
    @Binding var age: Int
    @Binding var weightlb: Double
    @Binding var weightgoal: Double
    @Binding var selectedHeight: Double
    @Binding var selectionValue: Double
    @State private var isShowDialog = false
    @State private var input = ""
    @State private var editingField: EditingField = .none
    @Binding var image: String
    
    var body: some View {
        ZStack {
            VStack {
                ScrollView {
                    HStack {
                        Button {
                            gender = .man
                            image = "Image6"
                        } label: {
                            Image("man")
                                .renderingMode(.template)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40)
                                .foregroundColor(gender == .man ? .blue : .gray)
                        }
                        
                        Image(image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200)
                        
                        Button {
                            gender = .woman
                            image = "Image7"
                        } label: {
                            Image("woden")
                                .renderingMode(.template)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40)
                                .foregroundColor(gender == .woman ? .pink : .gray)
                        }
                    }
                    
                    VStack {
                        VStack {
                            Text("Height (\(height)) cm) (\(formattedValue(selectedHeight)) ft \(formattedValue(selectionValue)) in)")
                                .font(.system(size: 17))
                                .bold()
                                .foregroundColor(.green)
                            
                            SlidingRuler (
                                value: $selectedHeight,
                                in: 1...7,
                                step: 1,
                                snap: .fraction,
                                tick: .fraction
                            )
                            .padding()
                            
                            SlidingRuler (
                                value: $selectionValue,
                                in: 1...12,
                                step: 1,
                                snap: .fraction,
                                tick: .fraction
                            )
                            .padding()
                        }
                        
                        HStack(spacing: 20) {
                            stepperBox(title: "Weight(Ib)", value: $weightlb, field: .weightlb)
                                .padding(20)
                                .background(.gray.opacity(0.2))
                                .cornerRadius(12)
                            
                            stepperBoxAge(title: "Age", value: $age, field: .age)
                                .padding(20)
                                .background(.gray.opacity(0.2))
                                .cornerRadius(12)
                        }
                        
                        VStack {
                            Text("Target Weight Loss (Ib)")
                                .bold()
                            HStack {
                                stepperButton("-", action: { weightgoal -= 1 })
                                Text(String(format: "%.1f", weightgoal))
                                    .font(.title3)
                                    .frame(width: 50)
                                    .onTapGesture {
                                        input = "\(weightgoal)"
                                        editingField = .goal
                                        isShowDialog = true
                                    }
                                stepperButton("+", action: { weightgoal += 1 })
                            }
                        }
                        .padding(20)
                        .frame(maxWidth: .infinity)
                        .background(.gray.opacity(0.2))
                        .cornerRadius(12)
                        .padding(10)
                    }
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    if image == "Image6" {
                        gender = .man
                    } else if image == "Image7" {
                        gender = .woman
                    }
                }
            }
            ChooseWeight(isShowDialog: $isShowDialog, input: $input)
                .onChange(of: isShowDialog) { newValue in
                    if !newValue {
                        DispatchQueue.main.async {
                            if let value = Double(input) {
                                switch editingField {
                                case .weightlb: weightlb = Double(value)
                                case .age: age = Int(value)
                                case .goal: weightgoal = Double(value)
                                default: break
                                }
                            }
                            editingField = .none
                        }
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
    
    func formattedValue(_ value: Double) -> String {
        if value.truncatingRemainder(dividingBy: 1.0) == 0 {
            return String(format: "%.0f", value)
        } else {
            return String(format: "%.1f", value)
        }
    }
    
}

//#Preview {
//    USUnits()
//}
