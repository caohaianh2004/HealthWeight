//
//  ManageArmyBodyFat.swift
//  Health_Weight
//
//  Created by Boss on 27/06/2025.
//

import SwiftUI

struct ManageArmyBodyFat: View {
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
                Spacer()
                
                Text(localizedkey: "abc_army")
                    .font(.system(size: 18))
                    .bold()
                
                Spacer()
                
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
                    ArmyBodyFatUs()
                } else {
                    ArmyBodyFatMetric()
                }
            }
        }
        .onAppear {
            selectionTab = UserDefaults.standard.integer(forKey: "selectedTab")
        }
    }
}

#Preview {
    ManageArmyBodyFat()
}
