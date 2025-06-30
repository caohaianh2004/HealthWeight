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
    @Binding var metValueW: Double
    var columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    let textList = [
        "Walking: slow",
        "Walking: fast",
        "Running: slow",
        "Running: fast",
        "Running: cross-country",
         "Cycling: moderate",
         "Cycling: very fast",
         "Swimming: moderate",
         "Walking: moderate",
         "Hiking: cross-country",
         "Running: moderate",
         "Running: very fast",
         "Cycing: slow",
         "Cycing: fast",
         "Cycing: BMX or mountain",
         "Swimming: laps, vigorous"
    ]
    
    let activityMets: [String : Double] = [
        "Walking: slow": 2.0,
        "Walking: fast": 4.3,
        "Running: slow": 8.0,
        "Running: fast": 10.0,
        "Running: cross-country": 9.0,
        "Cycling: moderate": 6.0,
        "Cycling: very fast": 12.0,
        "Swimming: moderate": 6.0,
        "Walking: moderate": 3.5,
        "Hiking: cross-country": 7.0,
        "Running: moderate": 9.8,
        "Running: very fast": 11.5,
        "Cycing: slow" : 4.0,
        "Cycing: fast": 10.0,
        "Cycing: BMX or mountain": 8.5,
        "Swimming: laps, vigorous": 10.3
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
                    ForEach(textList, id: \.self) { list in
                        Button {
                            textWRCS = list
                            metValueW = activityMets[list] ?? 1.0
                        } label: {
                            Image(systemName: textWRCS == list ? "circle.circle.fill" : "circle.circle")
                                .foregroundColor(.black)
                            Text(list)
                                .foregroundColor(.black)
                                .font(.system(size: 13))
                        }
                        .padding(1)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
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
