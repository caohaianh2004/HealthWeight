//
//  BmrResult.swift
//  Health_Weight
//
//  Created by Boss on 20/06/2025.
//

import SwiftUI

struct BmrResult: View {
    @EnvironmentObject var route: Router
        
    var body: some View {
        VStack {
            toobal()
            
            ScrollView {
                Image("Image9")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300)
            }
        }
    }
    
    func toobal() -> some View {
        HStack {
            Button {
                route.navigateBack()
            } label: {
                Image(systemName: "arrow.left")
                    .font(.title)
                    .foregroundColor(.black)
            }
            Spacer()
            
            Text(localizedkey: "abc_bmrresult")
                .foregroundStyle(Color.black)
                .font(.title2)
                .frame(maxWidth: .infinity)
                .bold()
                .padding(.leading, -42)
        }
        .padding()
    }
}

#Preview {
    BmrResult()
}
