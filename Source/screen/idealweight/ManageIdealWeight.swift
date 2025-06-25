//
//  ManageIdealWeight.swift
//  Health_Weight
//
//  Created by Boss on 25/06/2025.
//

import SwiftUI

struct ManageIdealWeight: View {
    @EnvironmentObject var route: Router
    @State private var seletionTab = 0
    
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
                Spacer()
                
                Text(localizedkey: "abc_ideal")
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
            HStack {
                ForEach(["US Units", "Metric Units"], id: \.self) { tab in
                    Button {
                        seletionTab = tab == "US Units" ? 0 : 1
                    } label: {
                        Text(tab)
                            .padding(5)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 8)
                            .font(.system(size: 13))
                            .background(seletionTab == (tab == "US Units" ? 0 : 1) ? Color.green : Color.gray.opacity(0.3))
                            .foregroundStyle(seletionTab == (tab == "US Units" ? 0 : 1) ? Color.white : Color.black)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                    .padding(5)
                }
            }
            
            Group {
                if seletionTab == 0 {
                    IdealWeightUS()
                } else {
                    IdealWeightMetric()
                }
            }
        }
        .onAppear {
            seletionTab = UserDefaults.standard.integer(forKey: "selectedTab")
        }
    }
}

#Preview {
    ManageIdealWeight()
}
