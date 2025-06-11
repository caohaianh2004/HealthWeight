//
//  UsUnits.swift
//  Health_Weight
//
//  Created by Boss on 04/06/2025.
//

import SwiftUI

struct UsUnits: View {
    enum Gender {
        case man
        case woden
    }
    enum EditingField {
       case none, weight, age, goal
    }
    @State private var selectionGenden: Gender = .man
    @State private var height = 165
    @State private var age = 25
    @State private var weight = 153
    @State private var weightgoal = 160
    @State private var selectedHeight: Double = 4.0
    @State private var selectionValue: Double = 6.5
    @State private var isShowDialog = false
    @State private var input = ""
    @State private var editingField: EditingField = .none
    
    var body: some View {
        VStack {
            ScrollView {
                HStack {
                    Button {
                        selectionGenden = .man
                    } label: {
                        Image("man")
                            .renderingMode(.template)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40)
                            .foregroundColor(selectionGenden == .man ? .blue : .gray)
                    }
                    
                    Image(selectionGenden == .man ? "Image6" : "Image7")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200)
                    
                    Button {
                        selectionGenden = .woden
                    } label: {
                        Image("woden")
                            .renderingMode(.template)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40)
                            .foregroundColor(selectionGenden == .woden ? .pink : .gray)
                    }
                }
                
                VStack {
                    VStack {
                        Text("Height (\(height)) cm) (\(formattedValue(selectedHeight)) ft \(formattedValue(selectionValue)) in)")
                            .font(.system(size: 17))
                            .bold()
                            .foregroundColor(.green)

                        
                        Measure(selectedValue: $selectedHeight)
                        Text("Feet(ft)")
                            .font(.system(size: 15))
                            .padding(.top, -50)
                        
                        MeasureInch(selectionValue: $selectionValue)
                        Text("Inch(in)")
                            .font(.system(size: 15))
                            .padding(.top, -50)
                    }
                        
                    HStack(spacing: 20) {
                       
                        stepperBox(title: "Weight(Ib)", value: $weight, field: .weight)
                            .padding(20)
                            .border(Color.black)
                        
                        stepperBox(title: "Age", value: $age, field: .age)
                            .padding(20)
                            .border(Color.black)
                    }
                    
                    VStack {
                        Text("Target Weight Loss (Ib)")
                            .bold()
                        HStack {
                            stepperButton("-", action: { weightgoal -= 1 })
                            Text("\(weightgoal)")
                                .font(.title2)
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
                    .border(Color.black)
                    .padding(10)
                }
            }
        }
        
            ChooseWeight(isShowDialog: $isShowDialog, input: $input)
                     .onChange(of: isShowDialog) { newValue in
                         if !newValue {
                             if let value = Int(input) {
                                 switch editingField {
                                 case .weight: weight = value
                                 case .age: age = value
                                 case .goal: weightgoal = value
                                 default: break
                                 }
                             }
                             editingField = .none
                         }
                     }
}
    
    private func stepperBox(title: String, value: Binding<Int>, field: EditingField) -> some View {
        VStack {
            Text(title).bold()
            HStack {
                stepperButton("-", action: { value.wrappedValue -= 1 })
                Text("\(value.wrappedValue)")
                    .font(.title2)
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

#Preview {
    UsUnits()
}
