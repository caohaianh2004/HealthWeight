//
//  DailogHome.swift
//  Health_Weight
//
//  Created by Boss on 30/06/2025.
//

import SwiftUI

struct DailogHome: View {
    @Binding var isShowHome: Bool
    @State private var offSet: CGFloat = 1000
    @Binding var textHome: String
    @Binding var metValue: Double
    let textList = [
    "Cooking", "Heavy Cleaning: wash car, windows", "Moving: household furniture", "Playing w/kids: moderate effort", "Sex", "Standing in line", "Food Shopping: with cart", "Moving: carrying boxes", "Paint, paper, remodel: inside", "Reading: sitting", "Sleeping", "Watching TV"
    ]
    
    let activityMETs: [String: Double] = [
        "Cooking": 2.0,
        "Heavy Cleaning: wash car, windows": 3.5,
        "Moving: household furniture": 5.0,
        "Playing w/kids: moderate effort": 3.0,
        "Sex": 2.8,
        "Standing in line": 1.3,
        "Food Shopping: with cart": 2.3,
        "Moving: carrying boxes": 6.0,
        "Paint, paper, remodel: inside": 3.3,
        "Reading: sitting": 1.3,
        "Sleeping": 0.9,
        "Watching TV": 1.0
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
                            textHome = list
                            metValue = activityMETs[list] ?? 1.0
                        } label: {
                            Image(systemName: textHome == list ? "circle.circle.fill" : "circle.circle")
                                .foregroundColor(.black)
                            Text(list)
                                .foregroundColor(.black)
                                .font(.system(size: 13))
                        }
                        .padding(1)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                
//                Button {
//                    close()
//                } label: {
//                    Text(localizedkey: "abc_done")
//                        .frame(maxWidth: .infinity)
//                        .padding(10)
//                        .background(.green)
//                        .foregroundColor(.white)
//                        .bold()
//                        .cornerRadius(10)
//                }
//                .padding()
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
            isShowHome = false
        }
    }
}


