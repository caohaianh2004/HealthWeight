//
//  DailogKP.swift
//  Health_Weight
//
//  Created by Boss on 01/07/2025.
//

import SwiftUI

struct DailogKP: View {
    @State private var offSet: CGFloat = 1000
    @Binding var isShowKP: Bool
    @Binding var textKp: String
    @Binding var metkp: Double
    let textList = [
        "pounds",
        "kilograms"
    ]
    let activityKP: [String : Double] = [
        "pounds": 0.453592,
        "kilograms": 1.0
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
                        textKp = list
                        metkp = activityKP[list] ?? 1.0
                    } label: {
                        Image(systemName: textKp == list ? "circle.circle.fill" : "circle.circle")
                            .foregroundColor(.black)
                        Text(list)
                            .foregroundColor(.black)
                            .font(.system(size: 13))
                    }
                    .padding(1)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding()
            .background(.white)
            .cornerRadius(12)
            .padding(130)
            .offset(y: offSet)
            .onAppear {
                if textKp.isEmpty {
                    textKp = "pounds"
                    metkp = activityKP["pounds"] ?? 0.453592
                }
                withAnimation(.spring()) {
                    offSet = 0
                }
            }
        }
    }
    
    func close() {
        withAnimation(.spring()) {
            offSet = 1000
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            isShowKP = false
        }
    }
}


