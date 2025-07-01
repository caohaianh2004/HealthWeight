//
//  ChooseWeight.swift
//  Health_Weight
//
//  Created by Boss on 05/06/2025.
//

import SwiftUI

struct ChooseWeight: View {
    @Binding var isShowDialog: Bool
    @Binding var input: String
    @State private var offSet: CGFloat = 1000
    @State private var inputText = ""

    let numbers = [
        ["1", "2", "3"],
        ["4", "5", "6"],
        ["7", "8", "9"],
        ["0", "."]
    ]

    var body: some View {
        ZStack {
            if isShowDialog {
                Color.clear
                    .ignoresSafeArea()
                    .onTapGesture {
                        close()
                    }
            }
            
            if isShowDialog {
                VStack(spacing: 16) {
                    HStack {
                        Spacer()
                        Button(action: {
                            close()
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .font(.title)
                                .foregroundColor(.gray)
                        }
                    }

                    Text(inputText.isEmpty ? "0" : inputText)
                        .font(.system(size: 32))
                        .bold()
                        .padding(.bottom, 10)

                    ForEach(numbers, id: \.self) { row in
                        HStack(spacing: 10) {
                            ForEach(row, id: \.self) { number in
                                Button {
                                    if inputText.count < 4 {
                                        inputText.append(number)
                                    }
                                } label: {
                                    Text(number)
                                        .font(.title)
                                        .frame(width: 70, height: 70)
                                        .background(Color.gray.opacity(0.5))
                                        .cornerRadius(10)
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                    }

                    HStack(spacing: 10) {
                        Button {
                            if !inputText.isEmpty {
                                inputText.removeLast()
                            }
                        } label: {
                            Image(systemName: "xmark.shield.fill")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                        }

                        Button {
                            input = inputText
                            isShowDialog = false
                        } label: {
                            Image(systemName: "checkmark.shield.fill")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                        }
                    }
                }
                .padding()
                .background(.ultraThinMaterial)
                .cornerRadius(14)
                .padding(.horizontal, 30)
                .shadow(radius: 8)
                .offset(y: offSet)
                .onAppear {
                    inputText = ""
                    withAnimation(.spring()) {
                        offSet = 0
                    }
                }
            }
        }
    }

    func close() {
        withAnimation(.spring()) {
            offSet = 1000
            isShowDialog = false
        }
    }
}


//#Preview {
//    ChooseWeight()
//}
