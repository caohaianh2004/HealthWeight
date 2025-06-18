//
//  MoreList.swift
//  Health_Weight
//
//  Created by Boss on 18/06/2025.
//

import SwiftUI

struct MoreList: View {
    @Binding var isShowMore: Bool
    @State private var offSet: CGFloat = 1000
    @State private var selectionButtonone: Int? = nil
    @State private var selectionButtontwo: Int? = nil
    @State private var inputText = ""
    let moreListone = [
        1: "Calories",
        2: "Kilojoules",
    ]
    let moreListtwo = [
        3: "Mifflin St Joer",
        4: "Revised Harris-Benedict",
        5: "Katch-McArdle"
    ]
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.3)
                .ignoresSafeArea()
                .onTapGesture {
                    close()
                }
            VStack {
                VStack {
                    Text(localizedkey: "abc_results")
                        .bold()
                        .font(.title3)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(5)
                    
                    HStack {
                        buttonTextone(1)
                        buttonTextone(2)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(5)
                    
                    Text(localizedkey: "abc_BMr")
                        .bold()
                        .font(.title3)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(5)
                    
                    buttonTexttwo(3)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(5)
                    
                    buttonTexttwo(4)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(5)
                    
                    HStack {
                        buttonTexttwo(5)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(5)
                        Text(localizedkey: "abc_bodyfat")
                            .foregroundStyle(Color.green)
                        
                        Spacer()
                        Text("20%")
                            .padding(5)
                            .border(Color.black)
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                        Spacer()
                    }
                }
                
                Button {
                    close()
                } label: {
                    Text(localizedkey: "abc_done")
                        .frame(maxWidth: .infinity)
                        .padding(10)
                        .background(.green)
                        .foregroundColor(.white)
                        .bold()
                        .cornerRadius(10)
                }
                .padding()
            }
            .padding()
            .background(.white)
            .cornerRadius(15)
            .padding()
            .offset(y: offSet)
            .onAppear {
                withAnimation(.spring()) {
                    offSet = 0
                }
                if selectionButtonone == nil {
                    selectionButtonone = 1
                }
                if selectionButtontwo == nil {
                    selectionButtontwo = 3
                }
            }
        }
    }
    
    func buttonTextone(_ index: Int) -> some View {
        Button {
            withAnimation {
                selectionButtonone = index
                inputText = moreListone[index] ?? ""
            }
        } label: {
            Image(systemName: selectionButtonone == index ? "circle.circle.fill" : "circle.circle")
                .foregroundColor(.black)
            Text(moreListone[index] ?? "")
                .foregroundColor(.black)
        }
    }
    
    func buttonTexttwo(_ index: Int) -> some View {
        Button {
            withAnimation {
                selectionButtontwo = index
                inputText = moreListtwo[index] ?? ""
            }
        } label: {
            Image(systemName: selectionButtontwo == index ? "circle.circle.fill" : "circle.circle")
                .foregroundColor(.black)
            Text(moreListtwo[index] ?? "")
                .foregroundColor(.black)
        }
    }
    
    func close() {
        withAnimation(.spring) {
           offSet = 1000
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            isShowMore = false
        }
    }
}

//#Preview {
//    MoreList()
//}
