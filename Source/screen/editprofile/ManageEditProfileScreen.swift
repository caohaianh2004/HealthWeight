//
//  EditProfileScreen.swift
//  Health_Weight
//
//  Created by Boss on 04/06/2025.
//

import SwiftUI

struct ManaEditProfileScreen: View {
    @EnvironmentObject var route: Router
    @State private var selectionTab = 0
    
    var body: some View {
            HStack {
                Text(localizedkey:"abc_create_your_profile")
                    .font(.system(size: 20))
                    .bold()
                    .padding(.leading, 100)
                
                Button {
                    route.navigateTo(.home)
                } label: {
                    Text(localizedkey: "abc_next")
                        .frame(width: 80, height: 40)
                        .foregroundColor(.white)
                        .bold()
                        .background(Color.green)
                        .cornerRadius(5)
                        .padding(.leading, 20)
                }
            }
            
            HStack(spacing: 0) {
                ForEach(["US Units", "Metric Units"], id: \.self) { title in
                    Button {
                        selectionTab = title == "US Units" ? 0 : 1
                    } label: {
                        Text(title)
                            .padding(5)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 8)
                            .font(.system(size: 13))
                            .bold()
                            .background(selectionTab == (title == "US Units" ? 0 : 1) ? Color.green : Color.gray.opacity(0.2))
                            .foregroundStyle(selectionTab == (title == "US Units" ? 0 : 1) ? Color.white : Color.black)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                    .padding(5)
                }
            }
            .padding()
            
            Group {
                if selectionTab == 0 {
                    UsUnits()
                } else {
                    MetricUnits()
                }
            }
        }
    }

#Preview {
        ManaEditProfileScreen()
}
