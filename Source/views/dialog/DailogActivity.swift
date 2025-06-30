//
//  DailogActivity.swift
//  Health_Weight
//
//  Created by Boss on 30/06/2025.
//

import SwiftUI

struct DailogActivity: View {
    @Binding var isActivitytext: String
    @Binding var isShowActivy: Bool
    @State private var offSet: CGFloat = 1000
    let textActivity = [
        "Walking, Running, Cycling, Swimming",
        "Gym Activities",
        "Training and Sports Activities",
        "Outdoor Activities",
        "Home & Daily Life Activities"
    ]
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.3)
                .ignoresSafeArea()
                .onTapGesture {
                    close()
                }
            VStack {
                ForEach(textActivity, id: \.self) { list in
                    Button {
                        isActivitytext = list
                        close()
                    } label: {
                        Image(systemName: isActivitytext == list ? "circle.circle.fill" : "circle.circle")
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
    
    func close() {
        withAnimation(.spring()) {
            offSet = 1000
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            isShowActivy = false
        }
    }
}

//#Preview {
//    DailogActivity()
//}
