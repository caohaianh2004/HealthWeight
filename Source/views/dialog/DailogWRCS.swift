//
//  DailogWRCS.swift
//  Health_Weight
//
//  Created by Boss on 30/06/2025.
//

import SwiftUI

struct DailogWRCS: View {
    @Binding var isShowWRCS: Bool
    @State private var offSet: CGFloat = 1000
    @Binding var textWRCS: String
    @State private var buttonWRCS: Int? = nil
    @State private var wrcsFacyor: Double = 1.0
    @Binding var metValueW: Double
    var columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    let textList = [
        1: "Walking: slow",
        2: "Walking: fast",
        3: "Running: slow",
        4: "Running: fast",
        5: "Running: cross-country",
        6: "Cycling: moderate",
        7: "Cycling: very fast",
        8: "Swimming: moderate",
        9: "Walking: moderate",
        10: "Hiking: cross-country",
        11: "Running: moderate",
        12: "Running: very fast",
        13: "Cycing: slow",
        14: "Cycing: fast",
        15: "Cycing: BMX or mountain",
        16: "Swimming: laps, vigorous"
    ]
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.3)
                .ignoresSafeArea()
                .onTapGesture {
                    close()
                }
            VStack {
                LazyVGrid(columns: columns) {
                    ForEach(1...16, id: \.self) { index in
                        buttontext(index)
                            .font(.system(size: 12))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            
                    }
                    .padding(1)
                }
                
            }
            .padding()
            .background(Color.white)
            .cornerRadius(15)
            .padding()
            .offset(y: offSet)
            .onAppear {
                withAnimation(.spring()) {
                    offSet = 0
                }
            }
        }
    
    }
    @ViewBuilder
    func buttontext(_ index: Int) -> some View {
        Button {
            withAnimation {
                buttonWRCS = index
                textWRCS = textList[index] ?? ""
                metValueW = wrcsFacyor
                switch index {
                case 1: wrcsFacyor = 2.0
                case 2: wrcsFacyor = 4.3
                case 3: wrcsFacyor = 8.0
                case 4: wrcsFacyor = 10.0
                case 5: wrcsFacyor = 9.0
                case 6: wrcsFacyor = 6.0
                case 7: wrcsFacyor = 12.0
                case 8: wrcsFacyor = 6.0
                case 9: wrcsFacyor = 3.5
                case 10: wrcsFacyor = 7.0
                case 11: wrcsFacyor = 9.8
                case 12: wrcsFacyor = 11.5
                case 13: wrcsFacyor = 4.0
                case 14: wrcsFacyor = 10.0
                case 15: wrcsFacyor = 8.5
                case 16: wrcsFacyor = 10.3
                default: wrcsFacyor = 2.0
                }
            }
        } label: {
            Image(systemName: buttonWRCS == index ? "circle.circle.fill" : "circle.circle")
                .foregroundColor(.black)
            Text(textList[index] ?? "")
                .font(.system(size: 14))
                .fontWeight(buttonWRCS == index ? .bold : .regular)
                .foregroundStyle(Color.black)
        }
    }
    
    func close() {
        withAnimation(.spring()) {
            offSet = 1000
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            isShowWRCS = false
        }
    }
}

//#Preview {
//    DailogWRCS()
//}
