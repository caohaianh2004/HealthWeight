//
//  LeanBodyResult.swift
//  Health_Weight
//
//  Created by Boss on 25/06/2025.
//

import SwiftUI

struct LeanBodyResult: View {
    @EnvironmentObject var route: Router
    
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
                Text(localizedkey: "abc_textlean")
                    .frame(maxWidth: .infinity)
                    .font(.system(size: 18))
                    .bold()
                Image("information")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20)
            }
            .padding()
            
            Image("basslean")
                .resizable()
                .scaledToFit()
                .frame(width: 300)
            
            
        }
        Spacer()
    }
}

#Preview {
    LeanBodyResult()
}
