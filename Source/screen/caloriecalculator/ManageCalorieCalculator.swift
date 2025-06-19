//
//  ManageCalorieCalculator.swift
//  Health_Weight
//
//  Created by Boss on 17/06/2025.
//

import SwiftUI

struct ManageCalorieCalculator: View {
    @EnvironmentObject var route: Router
    @State private var selectionTab = 0
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    route.navigateBack()
                } label: {
                    Image(systemName: "arrow.backward")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30)
                        .foregroundColor(.black)
                }
                
                Spacer()
                
                Text(localizedkey: "abc_calorie")
                    .font(.title3)
                    .bold()
                
                Spacer()
                
                Button {
                    
                } label: {
                    Image("information")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25)
                }
            }
            .padding()
            
            HStack {
                ForEach(["US Units", "Metric Units"], id: \.self) { tab in
                    Button {
                        selectionTab = tab == "US Units" ? 0 : 1
                    } label: {
                        Text(tab)
                            .padding(5)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 8)
                            .font(.system(size: 13))
                            .bold()
                            .background(selectionTab == (tab == "US Units" ? 0 : 1) ? .green : .gray.opacity(0.3))
                            .foregroundStyle(selectionTab == (tab == "US Units" ? 0 : 1) ? .white : .black)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                    .padding(5)
                }
            }
            
            Group {
                if selectionTab == 0 {
                    ViewUs()
                } else {
                  ViewMetric()
                }
            }
        }
        .onAppear {
            selectionTab = UserDefaults.standard.integer(forKey: "selectedTab")
        }
    }
}

#Preview {
    ManageCalorieCalculator()
}
