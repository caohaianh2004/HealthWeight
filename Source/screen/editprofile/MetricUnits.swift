//
//  MetricUnits.swift
//  Health_Weight
//
//  Created by Boss on 04/06/2025.
//

import SwiftUI

struct MetricUnits: View {
    enum Gender {
        case man
        case woden
    }
    enum EditingField {
        case none, weight, age, goal
    }
    @State private var selectionGenden: Gender = .man
    @Binding var heightCm: Double
    @Binding var age: Int
    @Binding var weight: Double
    @Binding var weightgoal: Double
    @State private var isShowDialog = false
    @State private var input = ""
    @State private var editingField: EditingField = .none
    @EnvironmentObject var userViewModel: UserViewModel
    
    var body: some View {
        VStack {
            ScrollView {
                HStack {
                    Button {
                        selectionGenden = .man
                        weight = 72.1
                        weightgoal = 65.2
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
                        weight = 50.5
                        weightgoal = 50.4
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
                    Text("Height (\(formattedHeight(heightCm)) cm)")
                        .font(.system(size: 17))
                        .foregroundColor(.green)
                        .bold()
                    MeasureHeight(selectionheight: $heightCm)
                       
                    
                    HStack(spacing: 20) {
                        stepperBox(title: "Weight(Kg)", value: $weight, field: .weight)
                            .padding(20)
                            .border(Color.black)
                        
                        stepperBoxAge(title: "Age", value: $age, field: .age)
                            .padding(20)
                            .border(Color.black)
                    }
                    
                    VStack {
                        Text("Target Weight Loss (Ib)")
                            .bold()
                        HStack {
                            stepperButton("-", action: { weightgoal -= 1 })
                            Text(String(format: "%.1f", weightgoal))
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
                    if let value = Double(input) {
                        switch editingField {
                        case .weight: weight = Double(value)
                        case .age: age = Int(value)
                        case .goal: weightgoal = Double(value)
                        default: break
                        }
                    }
                    editingField = .none
                }
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
    
    func formattedHeight(_ value: Double) -> String {
        if value.truncatingRemainder(dividingBy: 1.0) == 0 {
            return String(format: "%.0f", value)
        } else {
            return String(format: "%.1f", value)
        }
    }
    
}

//#Preview {
//    MetricUnits()
//}
