//
//  DialogTrainingSports.swift
//  Health_Weight
//
//  Created by Boss on 30/06/2025.
//

import SwiftUI

struct DialogTrainingSports: View {
    @Binding var isShowTraingSports: Bool
    @State private var offSet: CGFloat = 1000
    @Binding var textView: String
    @Binding var metTraining: Double
    let textList = [
    "Carrying & stacking wood", "Fishing", "Mowing Lawn: pushm hand", "Operate Snow Blower: walking", "Shoveling Snow: by hand", "Chopping & spliting wood", "Gardeting: general", "Mowing lawn: push, power", "Raking lawn"
    ]
    
    let customActivities: [String: Double] = [
        "Carrying & stacking wood": 5.5,
         "Fishing": 3.0,
         "Mowing Lawn: push hand": 5.0,
         "Operate Snow Blower: walking": 4.5,
         "Shoveling Snow: by hand": 6.0,
         "Chopping & splitting wood": 6.0,
         "Gardening: general": 4.0,
         "Mowing lawn: push, power": 5.5,
         "Raking lawn": 4.0
    ]
    
    let colums = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.3)
                .ignoresSafeArea()
                .onTapGesture {
                    close()
                }
            VStack {
                LazyVGrid(columns: colums) {
                    ForEach(textList, id: \.self) { list in
                        Button {
                            textView = list
                            metTraining = customActivities[list] ?? 1.0
                        } label: {
                            HStack {
                                Image(systemName: textView == list ? "circle.circle.fill" : "circle.circle")
                                    .foregroundColor(.black)
                                Text(list)
                                    .foregroundColor(.black)
                                    .font(.system(size: 13))
                            }
                            .padding(1)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
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
            }
        }
   
    }
    
    func close() {
        withAnimation(.spring()) {
            offSet = 1000
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            isShowTraingSports = false
        }
    }
}

//#Preview {
//    DialogTrainingSports()
//}
