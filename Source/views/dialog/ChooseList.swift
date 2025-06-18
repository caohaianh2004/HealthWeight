//
//  ChooseList.swift
//  Health_Weight
//
//  Created by Boss on 18/06/2025.
//

import SwiftUI

struct ChooseList: View {
    @Binding var isPresentedtext: String
    @Binding var iSShowList: Bool
    @State private var offSet: CGFloat = 1000
    @State private var selectedButton: Int? = nil
    let textList = [
        1: "Basal Metabolic Rate (BMR)",
        2: "Sedentary: little or no exercise",
        3: "Light: exercise 1-3 times/week",
        4: "Moderate: exericise 4-5 times/week",
        5: "Active: daily exercise of intence exercise 3-4 times/week",
        6: "Very Active: intense exercise 6-7 times/week",
        7: "Extra Active: very intense exercise daily, or physical job"
    ]
    
    var body: some View {
        ZStack {
                Color.black.opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture {
                        close()
                    }
            
                VStack {
                    ForEach(1...7, id: \.self) { index in
                        buttonText(index)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(5)
                    }
                    
                    Button {
                        close()
                    } label: {
                        Text(localizedkey: "abc_done")
                            .frame(maxWidth: .infinity)
                            .padding(10)
                            .background(.green)
                            .foregroundColor(.white)
                            .bold()
                            .cornerRadius(10)
                    }
                }
                .padding()
                .background(.white)
                .cornerRadius(15)
                .padding()
                .offset(y: offSet)
                .onAppear {
                    withAnimation(.spring()) {
                        offSet = 0
                    }
                    if selectedButton == nil {
                    selectedButton = 1
                        isPresentedtext = textList[1] ?? ""
                    }

                }
            }
        }
    
    @ViewBuilder
    func buttonText(_ index: Int) -> some View {
        Button {
            withAnimation {
                selectedButton = index
                isPresentedtext = textList[index] ?? ""
            }
        } label: {
            HStack {
                Image(systemName: selectedButton == index ? "circle.circle.fill" : "circle.circle")
                    .foregroundColor(.black)
                Text(textList[index] ?? "")
                    .font(.system(size: 14))
                    .fontWeight(selectedButton == index ? .bold : .regular)
                    .foregroundStyle(Color.black)
            }
        }
    }
    
    func close() {
        withAnimation(.spring()){
            offSet = 1000
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
          iSShowList = false
        }
    }
}

//#Preview {
//    ChooseList()
//}
