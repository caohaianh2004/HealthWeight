//
//  Result.swift
//  Health_Weight
//
//  Created by Boss on 19/06/2025.
//

import SwiftUI

struct Result: View {
    @EnvironmentObject var route: Router
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    route.navigateBack()
                } label: {
                    Image(systemName: "arrow.backward")
                        .font(.title)
                        .foregroundColor(.black)
                }
                .padding()
                Spacer()
                
                Text(localizedkey: "abc_calorie")
                    .font(.title2)
                    .bold()
                    .frame(maxWidth: .infinity)
                    .padding(.leading, -54)
                
                Spacer()
            }
            Text(localizedkey: "abc_textresult")
                .font(.system(size: 15))
                .padding(5)
            
            HStack {
                Text(localizedkey: "abc_maintain")
                    .frame(width: 200, height: 30)
                    .padding()
                    .background(.blue.opacity(0.7))
                    .cornerRadius(10)
                    .font(.system(size: 15))
                    .frame(maxWidth: .infinity)
                VStack {
                    Text("1,884")
                        .font(.system(size: 20))
                        .bold()
                    Text("Calorie/day")
                        .font(.system(size: 14))
                        .frame(width: 120)
                }
            }
        }
        Spacer()
    }
}

#Preview {
    Result()
}
