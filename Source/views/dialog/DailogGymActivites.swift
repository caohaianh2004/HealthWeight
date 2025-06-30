//
//  DailogGymActivites.swift
//  Health_Weight
//
//  Created by Boss on 30/06/2025.
//

import SwiftUI

struct DailogGymActivites: View {
    @Binding var isShowGym: Bool
    @Binding var textGym: String
    @State private var offSet: CGFloat = 1000
    @Binding var metGym: Double
    let activities = [
        "Walking: slow", "Walking: fast", "Running: slow", "Running: fast",
        "Running: cross-country", "Cycling: moderate", "Cycling: very fast",
        "Swimming: moderate", "Walking: moderate", "Hiking: cross-country",
        "Running: moderate", "Running: very fast", "Cycling: slow",
        "Cycling: fast", "Cycling: BMX or mountain", "Swimming: laps, vigorous"
    ]
    
    let activityMETs: [String: Double] = [
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
        "Cycling: slow": 4.0,
        "Cycling: fast": 10.0,
        "Cycling: BMX or mountain": 8.5,
        "Swimming: laps, vigorous": 10.3
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
                    ForEach(activities, id: \.self) { gym in
                        Button {
                            textGym = gym
                            metGym = activityMETs[gym] ?? 1.0
                        } label: {
                            HStack {
                                Image(systemName: textGym == gym ? "circle.circle.fill" : "circle.circle")
                                    .foregroundColor(.black)
                                Text(gym)
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
            isShowGym = false
        }
    }
}

//#Preview {
//    DailogGymActivites()
//}
