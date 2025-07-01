//
//  DailogSP.swift
//  Health_Weight
//
//  Created by Boss on 01/07/2025.
//

import SwiftUI

struct DailogSP: View {
    @Binding var isShowSP:Bool 
    @Binding var textSp: String
    @Binding var metSp: Double
    @State private var offSet: CGFloat = 1000
    let textList = [
        "minutes per mile",
        "miles per hour",
        "yards per second",
        "minutes per kilometer",
        "kilometers per hour",
        "meters per second"
    ]
    let activitymetSp:[String : Double] = [
        "minutes per mile": 9.8,
        "miles per hour": 8.0,
        "yards per second": 8.5,
        "minutes per kilometer": 10.0,
        "kilometers per hour": 7.0,
        "meters per second": 8.3
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
                        textSp = list
                        metSp = activitymetSp[list] ?? 8.0
                    } label: {
                        Image(systemName: textSp == list ? "circle.circle.fill" : "circle.circle")
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
                if textSp.isEmpty {
                    textSp = "minutes per mile"
                    metSp = activitymetSp["minutes per mile"] ?? 9.8
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
            isShowSP = false
        }
    }
}


