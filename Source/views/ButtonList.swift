//
//  ButtonList.swift
//  Health_Weight
//
//  Created by Boss on 18/06/2025.
//

import SwiftUI

struct ButtonList: View {
    @State private var seletedtext = "Basal Metabolic Rate (BMR)"
    @Binding  var isShowDialog: Bool
    
    var body: some View {
        ZStack {
            Button {
                isShowDialog = true
            } label: {
                HStack {
                    Text(seletedtext)
                        .foregroundStyle(Color.black)
                    Spacer()
                    Image(systemName: "arrowtriangle.down.fill")
                        .foregroundColor(.black)
                }
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(12)
                
            }
            .padding()
            
            if isShowDialog {
                ChooseList(isPresentedtext: $seletedtext, iSShowList: $isShowDialog)
            }
        }
    }
}


