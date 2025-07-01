//
//  DailogWRC.swift
//  Health_Weight
//
//  Created by Boss on 01/07/2025.
//

import SwiftUI

struct DailogWRC: View {
    @Binding var isShowWRC: Bool
    @Binding var textWRC: String
    @Binding var metWrc: Double 
    @State private var offSet: CGFloat = 1000
    let textList = [
        "Walking",
        "Running",
        "Cycling"
    ]
    let activityMest: [String : Double] = [
        "Walking": 3.5,
        "Running": 9.8,
        "Cycling": 7.5
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
                        textWRC = list
                        metWrc = activityMest[list] ?? 1.0
                    } label: {
                        Image(systemName: textWRC == list ? "circle.circle.fill" : "circle.circle")
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
            .padding(50)
            .offset(y: offSet)
            .onAppear {
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
            isShowWRC = false
        }
    }
}


