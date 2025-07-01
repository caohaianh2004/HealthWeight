//
//  DailogDistance.swift
//  Health_Weight
//
//  Created by Boss on 01/07/2025.
//

import SwiftUI

struct DailogDistance: View {
    @Binding var isShowDistance: Bool
    @State private var offSet: CGFloat = 1000
    @Binding var textDistance: String
    @Binding var metDistance: Double
    let textList = [
        "miles",
        "yards",
        "kilometers",
        "meters"
    ]
    
    let activityMet: [String : Double] = [
        "miles": 1.036,
        "kilometers": 0.612,
        "yards": 0.00059,
        "meters": 0.000612
    ]
    var body: some View {
        ZStack {
            Color.black.opacity(0.3)
                .ignoresSafeArea()
                .onTapGesture {
                    close()
                }
            VStack {
                ForEach(textList, id: \.self) { list in
                    Button {
                        textDistance = list
                        metDistance = activityMet[list] ?? 0.612
                    } label: {
                        Image(systemName: textDistance == list ? "circle.circle.fill" : "circle.circle")
                            .foregroundColor(.black)
                        Text(list)
                            .foregroundStyle(Color.black)
                            .font(.system(size: 13))
                    }
                    .padding(1)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding()
            .background(.white)
            .cornerRadius(12)
            .padding(50)
            .offset(y: offSet)
            .onAppear {
                withAnimation(.spring()) {
                    offSet = 0
                }
                
                if textDistance.isEmpty {
                    textDistance = "miles"
                    metDistance = activityMet["miles"] ?? 1.036
                }
            }
        }
    }
    
    func close() {
        withAnimation(.spring()) {
            offSet = 1000
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            isShowDistance = false
        }
    }
}

