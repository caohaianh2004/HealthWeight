//
//  AddWeight.swift
//  Health_Weight
//
//  Created by Boss on 11/06/2025.
//

import SwiftUI

struct AddWeight: View {
    @EnvironmentObject var route: Router
    @State private var selectionKg: Double = 10.0
    
    var body: some View {
        VStack {
            addWeightTopbar()
            Spacer()
            
            VStack {
                Image("Image6")
                    .resizable()
                    .scaledToFit()
                    .frame( height: 300)
            
                MeasureKg(selectionKg: $selectionKg)
            
            }
            Spacer()
        }
    }
    
    @ViewBuilder
    func addWeightTopbar() -> some View {
        HStack {
            Button {
                route.navigateBack()
            }label: {
                    Image(systemName: "arrow.left")
                        .foregroundColor(.black)
                        .font(.title)
            }
            
            Spacer()
            
            Text(localizedkey: "abc_weightToday")
                .font(.headline)
            
            Spacer()
            
            Button {
                
            } label: {
                Text(localizedkey: "abc_next")
                    .padding(10)
                    .foregroundStyle(Color.white)
                    .background(Color.green)
                    .cornerRadius(15)
            }
        }
        .padding()
    }

}

#Preview {
    AddWeight()
}
