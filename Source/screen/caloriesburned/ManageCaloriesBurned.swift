//
//  ManageCaloriesBurned.swift
//  Health_Weight
//
//  Created by Boss on 30/06/2025.
//

import SwiftUI

struct ManageCaloriesBurned: View {
    @EnvironmentObject var route: Router
    @State private var selectionTab = 0
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    route.navigateBack()
                } label: {
                    Image(systemName: "arrow.left")
                        .foregroundColor(.black)
                        .font(.title2)
                }
                
                Text(localizedkey: "abc_caloriesBurned")
                    .frame(maxWidth: .infinity)
                    .font(.system(size: 18))
                    .bold()
                
                Button {
                    
                } label: {
                    Image("information")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20)
                }
            }
            .padding()
            
            HStack {
                ForEach(["Calories \n Burned", "Calorie Burned by Distance"], id: \.self) { tab in
                    Button {
                        selectionTab = tab == "Calories \n Burned" ? 0 : 1
                    } label: {
                        Text(tab)
                            .frame(maxWidth: .infinity)
                            .padding(10)
                            .frame(height: 60)
                            .font(.system(size: 16))
                            .background(selectionTab == (tab == "Calories \n Burned" ? 0 : 1) ? Color.green : Color.gray.opacity(0.3))
                            .foregroundStyle(selectionTab == (tab == "Calories \n Burned" ? 0 : 1) ? Color.white : Color.black)
                            .bold()
                            .cornerRadius(12)
                    }
                    .padding(10)
                }
            }
            
            Group {
                if selectionTab == 0 {
                    CaloriesBurned()
                } else {
                    CalorieBurnedByDistance()
                }
            }
        }
    }
}

#Preview {
    ManageCaloriesBurned()
}
