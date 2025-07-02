//
//  WeightTracker.swift
//  Health_Weight
//
//  Created by Boss on 02/07/2025.
//

import SwiftUI

struct WeightTracker: View {
    let weight = [
        "Start Weight",
        "Current Weight",
        "Target Weight"
    ]
    
    @EnvironmentObject var route: Router
    @State private var textWeight = ""
    
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
                
                Text(localizedkey: "abc_weighttracker")
                    .font(.system(size: 18))
                    .frame(maxWidth: .infinity)
                    .bold()
            }
            .padding()
            
            HStack {
                ForEach(weight, id: \.self) { weightkl in
                    Button {
                        textWeight = weightkl
                    } label: {
                        Text(weightkl)
                            .foregroundStyle(Color.black)
                            .font(.system(size: 13))
                    }
                    .padding()
                }
            }
            
            
        }
    }
}

#Preview {
    WeightTracker()
}
