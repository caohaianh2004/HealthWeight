//
//  ManageBodyFat.swift
//  Health_Weight
//
//  Created by Boss on 23/06/2025.
//

import SwiftUI

struct ManageBodyFat: View {
    @State private var selectionTab = 0
    @EnvironmentObject var route: Router
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    route.navigateBack()
                } label: {
                    Image(systemName: "arrow.left")
                        .font(.title)
                        .foregroundColor(.black)
                }
                Spacer()
                
                Text(localizedkey: "abc_bodyFat")
                    .font(.system(size: 20))
                    .bold()
                Spacer()
                Image("information")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30)
            }
            .padding()
            
            HStack {
                ForEach(["US Units", "Metric Units"], id: \.self) { tab in
                    Button {
                        selectionTab = tab == "US Units" ? 0 : 1
                    } label: {
                        Text(tab)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .font(.system(size: 15))
                            .foregroundStyle(selectionTab == (tab == "US Units" ? 0 : 1) ? Color.white : Color.black)
                            .background(selectionTab == (tab == "US Units" ? 0 : 1) ? Color.green : Color.gray.opacity(0.3))
                            .cornerRadius(12)
                            .bold()
                    }
                    .padding(5)
                }
            }
            
            Group {
                if selectionTab == 0 {
                    BodyUS()
                } else {
                    BodyMetric()
                }
            }
        }
        .onAppear {
            selectionTab = UserDefaults.standard.integer(forKey: "selectedTab")
        }
    }
}

#Preview {
    ManageBodyFat()
}
