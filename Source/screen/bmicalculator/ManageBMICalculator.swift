//
//  ManageBMICalculator.swift
//  Health_Weight
//
//  Created by Boss on 12/06/2025.
//

import SwiftUI

struct ManageBMICalculator: View {
    @EnvironmentObject var route: Router
    @State private var selectionTab = 0
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    route.navigateBack()
                } label: {
                    Image(systemName: "arrow.backward")
                        .font(.title2)
                        .foregroundColor(.black)
                }
                
                Text(localizedkey: "abc_bmiCalcuator")
                    .frame(maxWidth: .infinity)
                    .font(.system(size: 18))
                    .bold()
                
                Spacer()
                
                Button {
                    /**Nhập nội dung**/
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
                        selectionTab = tab == "US Units" ? 0 : 1
                    } label: {
                        Text(tab)
                            .padding(5)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 8)
                            .font(.system(size: 13))
                            .bold()
                            .background(selectionTab == (tab == "US Units" ? 0 : 1) ? Color.green : Color.gray.opacity(0.3))
                            .foregroundColor(selectionTab == (tab == "US Units" ? 0 : 1) ? Color.white : Color.black)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                    .padding(5)
                }
            }
            
            Group {
                if selectionTab == 0 {
                    USUnits()
                } else {
                    MetricUnitS()
                }
            }
        }
        .onAppear {
            selectionTab = UserDefaults.standard.integer(forKey: "selectedTab")
        }
    }
}

#Preview {
    ManageBMICalculator()
}
