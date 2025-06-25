//
//  ManageBMRCalculator.swift
//  Health_Weight
//
//  Created by Boss on 20/06/2025.
//

import SwiftUI

struct ManageBMRCalculator: View {
    @EnvironmentObject var route: Router
    @State private var selectiontab = 0
    @State private var selectedText = ""
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    route.navigateBack()
                } label: {
                    Image(systemName: "arrow.backward")
                        .foregroundColor(.black)
                        .font(.title2)
                }
                
                Text(localizedkey: "abc_bmr")
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
                ForEach(["US Units", "Metric Units"], id: \.self) { tab in
                    Button {
                        selectiontab = tab == "US Units" ? 0 : 1
                    } label: {
                        Text(tab)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .font(.system(size: 15))
                            .background(selectiontab == (tab == "US Units" ? 0 : 1) ? Color.green : Color.gray.opacity(0.5))
                            .foregroundStyle(selectiontab == (tab == "US Units" ? 0 : 1) ? Color.white : Color.black)
                            .cornerRadius(12)
                    }
                    .padding(5)
                }
            }
    
            Group {
                if selectiontab == 0 {
                    BmrUs()
                } else {
                    BmrMetric()
                }
            }
        }
        .onAppear {
            selectiontab = UserDefaults.standard.integer(forKey: "selectedTab")
        }
    }
}

#Preview {
    ManageBMRCalculator()
}
