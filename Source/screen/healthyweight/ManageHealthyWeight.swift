//
//  ManageHealthyWeight.swift
//  Health_Weight
//
//  Created by Boss on 26/06/2025.
//

import SwiftUI

struct ManageHealthyWeight: View {
    @EnvironmentObject var route: Router
    @State private var selectionTab = 0
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    route.navigateBack()
                } label: {
                    Image(systemName: "arrow.left")
                        .font(.title2)
                        .foregroundColor(.black)
                }
                
                Text(localizedkey: "abc_healthyweight")
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
            
            buttonUsMetric(selectionTab: $selectionTab)
            
            Group {
               if selectionTab == 0 {
                   HealthyUS()
               } else {
                   HealthyMetric()
               }
            }
        }
        .onAppear {
            selectionTab = UserDefaults.standard.integer(forKey: "selectedTab")
        }
    }
}

struct buttonUsMetric: View {
    @Binding var selectionTab: Int
    
    var body: some View {
        HStack {
            ForEach(["US Units", "Metric Units"], id: \.self) { tab in
                Button {
                    selectionTab = tab == "US Units" ? 0 : 1
                } label: {
                    Text(tab)
                        .padding(10)
                        .frame(maxWidth: .infinity)
                        .font(.system(size: 15))
                        .foregroundStyle(selectionTab == (tab == "US Units" ? 0 : 1) ? Color.white : Color.black)
                        .background(selectionTab == (tab == "US Units" ? 0 : 1) ? Color.green : Color.gray.opacity(0.3))
                        .cornerRadius(10)
                }
                .padding(10)
            }
        }
    }
}

#Preview {
    ManageHealthyWeight()
}
