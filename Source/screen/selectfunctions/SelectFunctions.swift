//
//  SelectFunctions.swift
//  Health_Weight
//
//  Created by Boss on 06/06/2025.
//

import SwiftUI

struct SelectFunctions: View {
    @Environment(\.dismiss) var dismiss
    @State private var selection = true
    @State private var selection1 = true
    @State private var selection2 = true
    @State private var selection3 = true
    @State private var selection4 = true
    @State private var selection5 = true
    @State private var selection6 = true
    @State private var selection7 = true
    @State private var selection8 = true
    
    var body: some View {
        NavigationStack {
            ScrollView{
                VStack {
                    HStack {
                        Image("fame")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30)
                        Text("bmi calculator").textCase(.uppercase)
                            .font(.system(size: 15))
                        
                        Spacer()
                        
                        Button {
                            selection.toggle()
                        } label: {
                            Image(systemName: selection ? "circle.circle" : "circle.circle.fill")
                                .foregroundStyle(Color.black)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(6)
                    
                    HStack {
                        Image("fame126")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30)
                        Text("calorie calculator").textCase(.uppercase)
                            .font(.system(size: 15))
                        
                        Spacer()
                        
                        Button {
                            selection1.toggle()
                        } label: {
                            Image(systemName: selection1 ? "circle.circle" : "circle.circle.fill")
                                .foregroundStyle(Color.black)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(6)
                    
                    HStack {
                        Image("fame7")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30)
                        Text("bmr calculator").textCase(.uppercase)
                            .font(.system(size: 15))
                        
                        Spacer()
                        
                        Button {
                            selection2.toggle()
                        } label: {
                            Image(systemName: selection2 ? "circle.circle" : "circle.circle.fill")
                                .foregroundStyle(Color.black)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(6)
                    
                    HStack {
                        Image("fame221")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30)
                        Text("body fat calculator").textCase(.uppercase)
                            .font(.system(size: 15))
                        
                        Spacer()
                        
                        Button {
                            selection3.toggle()
                        } label: {
                            Image(systemName: selection3 ? "circle.circle" : "circle.circle.fill")
                                .foregroundStyle(Color.black)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(6)
                    
                    HStack {
                        Image("fame2")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30)
                        Text("ideal weight").textCase(.uppercase)
                            .font(.system(size: 15))
                        
                        Spacer()
                        
                        Button {
                            selection4.toggle()
                        } label: {
                            Image(systemName: selection4 ? "circle.circle" : "circle.circle.fill")
                                .foregroundStyle(Color.black)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(6)
                    
                    HStack {
                        Image("fame3")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30)
                        Text("lean body mass").textCase(.uppercase)
                            .font(.system(size: 15))
                        
                        Spacer()
                        
                        Button {
                            selection5.toggle()
                        } label: {
                            Image(systemName: selection5 ? "circle.circle" : "circle.circle.fill")
                                .foregroundStyle(Color.black)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(6)
                    
                    HStack {
                        Image("fame4")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30)
                        Text("healthy weight").textCase(.uppercase)
                            .font(.system(size: 15))
                        
                        Spacer()
                        
                        Button {
                            selection6.toggle()
                        } label: {
                            Image(systemName: selection6 ? "circle.circle" : "circle.circle.fill")
                                .foregroundStyle(Color.black)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(6)
                    
                    HStack {
                        Image("fame5")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30)
                        Text("army body fat").textCase(.uppercase)
                            .font(.system(size: 15))
                        
                        Spacer()
                        
                        Button {
                            selection7.toggle()
                        } label: {
                            Image(systemName: selection7 ? "circle.circle" : "circle.circle.fill")
                                .foregroundStyle(Color.black)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(6)
                    
                    HStack {
                        Image("fame6")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30)
                        Text("calories burned").textCase(.uppercase)
                            .font(.system(size: 15))
                        
                        Spacer()
                        
                        Button {
                            selection8.toggle()
                        } label: {
                            Image(systemName: selection8 ? "circle.circle" : "circle.circle.fill")
                                .foregroundStyle(Color.black)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(6)
                }
                .padding()
            }
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "arrow.left")
                            .foregroundColor(.black)
                            .font(.title2)
                    }
                }
                
                ToolbarItem(placement: .principal) {
                    Text("Select Functions")
                        .font(.system(size: 20))
                        .bold()
                }
            }
        }
    }
}

#Preview {
    SelectFunctions()
}
