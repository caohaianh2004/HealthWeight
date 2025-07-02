//
//  DailogWeight.swift
//  Health_Weight
//
//  Created by Boss on 02/07/2025.
//

import SwiftUI

struct DailogWeight: View {
    @Binding var isPresented: Bool
    var date: String
    var initialWeight: Float
    var onSave: (Float) -> Void

    @State private var offSet: CGFloat = 1000
    @State private var selectedInteger = 15
    @State private var selectedDecimal = 0
    let integerRange = 15...215
    let decimalRange = 0...9

    var body: some View {
        ZStack {
            Color.black.opacity(0.3).ignoresSafeArea()

            VStack {
                HStack {
                    Text("Your Weight")
                        .font(.headline)
                    Spacer()
                    Text(date)
                        .font(.headline)
                }
                .padding(.top, 20)
                .padding(.horizontal)

                HStack(spacing: 0) {
                    Picker("", selection: $selectedInteger) {
                        ForEach(integerRange, id: \.self) { value in
                            Text("\(value)").tag(value)
                        }
                    }
                    .frame(width: 60, height: 100)
                    .clipped()
                    .pickerStyle(.wheel)

                    Text(".")
                        .font(.title)
                        .frame(width: 20)

                    Picker("", selection: $selectedDecimal) {
                        ForEach(decimalRange, id: \.self) { value in
                            Text("\(value)").tag(value)
                        }
                    }
                    .frame(width: 60, height: 100)
                    .clipped()
                    .pickerStyle(.wheel)

                    Text("kg")
                        .bold()
                        .padding(.leading, 8)
                }

                HStack {
                    Button("CANCEL") {
                        close()
                    }
                    .frame(width: 80)
                    .padding()
                    .background(Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(10)

                    Button("OK") {
                        let weight = Float(selectedInteger) + Float(selectedDecimal) / 10.0
                        onSave(weight)
                        close()
                    }
                    .frame(width: 80)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                .padding(.bottom, 20)
            }
            .background(Color.white)
            .cornerRadius(20)
            .padding()
            .offset(y: offSet)
            .onAppear {
                withAnimation(.spring()) {
                    offSet = 0
                }

                // 👉 Chia phần nguyên và phần thập phân
                let parts = modf(Double(initialWeight))
                let intPart = Int(parts.0)
                let decimal = Int(round(parts.1 * 10))

                // ⚠️ Bảo vệ: tránh crash khi giá trị vượt khỏi Picker range
                selectedInteger = integerRange.contains(intPart) ? intPart : integerRange.lowerBound
                selectedDecimal = decimalRange.contains(decimal) ? decimal : decimalRange.lowerBound
            }


        }
    }

    func close() {
        withAnimation(.spring) {
            offSet = 1000
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            isPresented = false
        }
    }
}




//#Preview {
//    DailogWeight()
//}
