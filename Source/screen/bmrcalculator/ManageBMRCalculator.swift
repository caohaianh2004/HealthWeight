//
//  ManageBMRCalculator.swift
//  Health_Weight
//
//  Created by Boss on 20/06/2025.
//

import SwiftUI

struct ManageBMRCalculator: View {
    @State private var selectiontab = 0
    @State private var selectedText = ""
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "arrow.backward")
                    .foregroundColor(.black)
                    .font(.title)
                Spacer()
                
                Text(localizedkey: "abc_bmr")
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
                        selectiontab = tab == "US Units" ? 0 : 1
                    } label: {
                        Text(tab)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .font(.system(size: 15))
                            .background(selectiontab == (tab == "US Units" ? 0 : 1) ? Color.green : Color.gray)
                            .foregroundStyle(selectiontab == (tab == "US Units" ? 0 : 1) ? Color.white : Color.black)
                            .cornerRadius(13)
                    }
                    .padding(5)
                }
            }
            
            Group {
                if selectiontab == 1 {
                    BmrUs()
                } else {
                    BmrMetric()
                }
            }
        }
    }
}

#Preview {
    ManageBMRCalculator()
}
