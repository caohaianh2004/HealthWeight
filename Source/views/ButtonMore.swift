//
//  ButtonMore.swift
//  Health_Weight
//
//  Created by Boss on 18/06/2025.
//

import SwiftUI

struct ButtonMore: View {
    @Binding var isShowMore: Bool
    
    var body: some View {
        ZStack{
            Button {
                isShowMore = true
            } label: {
                HStack {
                    Image(systemName: "plus.circle")
                        .font(.title)
                        .foregroundColor(.black)
                    Text(localizedkey: "abc_more")
                        .foregroundStyle(Color.black)
                        .bold()
                }
            }
            
            if isShowMore {
                MoreList(isShowMore: $isShowMore)
            }
        }
    }
}

//#Preview {
//    ButtonMore()
//}
