//
//  WeightLb.swift
//  Health_Weight
//
//  Created by Boss on 12/06/2025.
//

import SwiftUI

struct WeightLb: View {
    var body: some View {
        VStack {
            
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
}

#Preview {
    WeightLb()
}
