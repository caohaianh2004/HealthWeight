//
//  HealthWeight.swift
//  Health_Weight
//
//  Created by Boss on 09/06/2025.
//

import SwiftUI

struct HealthWeight: View {
    @EnvironmentObject var route: Router
    let cloumns = [
        GridItem(.flexible()), GridItem(.flexible())
    ]
    @State private var showMenu = false
    
    var body: some View {
        ZStack {
            Color.gray.opacity(0.3).ignoresSafeArea()
            ScrollView {
                VStack {
                    HStack {
                        Button {
                            withAnimation {
                                showMenu.toggle()
                            }
                        } label: {
                            Image(systemName: "line.3.horizontal")
                                .resizable()
                                .frame(width: 24, height: 18)
                                .padding()
                                .foregroundColor(.black)
                        }
                        
                        Spacer()
                        
                        Button {
                            
                        } label: {
                            Image("crown")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                                .padding()
                        }
                    }
                    
                    Text(localizedkey: "abc_welcome")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(30)
                        .padding(.top, -42)
                    
                    HStack {
                        VStack {
                            Button {
                                
                            } label: {
                                HStack {
                                    Text(localizedkey: "abc_daily")
                                        .foregroundColor(.black)
                                        .bold()
                                    Image("hicon")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 20, height: 20)
                                }
                            }
                            
                            Button {
                                
                            } label: {
                                HStack {
                                    Image("scales")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 20, height: 20)
                                    Text("Weight")
                                        .foregroundStyle(Color.black)
                                        .font(.system(size: 15))
                                    Text("62 kg")
                                        .foregroundStyle(Color.black)
                                        .bold()
                                    Text("-1.0")
                                        .padding(5)
                                        .foregroundStyle(.white)
                                        .background(Color.red)
                                        .cornerRadius(5)
                                }
                            }
                            
                            Button {
                                
                            } label: {
                                HStack {
                                    Image("goal")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 20, height: 20)
                                    Text("Goal")
                                        .foregroundStyle(Color.black)
                                        .font(.system(size: 15))
                                    Text("68 kg")
                                        .foregroundStyle(Color.black)
                                        .bold()
                                    Text("+6.0")
                                        .padding(5)
                                        .foregroundStyle(.white)
                                        .background(Color.green)
                                        .cornerRadius(5)
                                }
                            }
                        }
                        Spacer()
                        
                        VStack {
                            Spacer()
                            Image("llustration")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                            Spacer()
                        }
                    }
                    .padding()
                    .background(Color.white.opacity(0.4))
                    .cornerRadius(15)
                    .padding()
                    .padding(.top, -30)
                    
                    Text(localizedkey: "abc_filtness")
                        .font(.system(size: 20))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .padding(.top, -20)
                    
                    LazyVGrid(columns: cloumns, content: {
                        Button {
                            
                        } label: {
                            VStack {
                                Image("fame")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 50)
                                Text(localizedkey: "abc_bmi")
                                    .font(.system(size: 15))
                                    .foregroundColor(.black)
                            }
                            .padding()
                            .background(Color.white.opacity(0.3))
                            .cornerRadius(13)
                        }
                        
                        Button {
                            
                        } label: {
                            VStack {
                                Image("fame126")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 50)
                                Text(localizedkey: "abc_calorice")
                                    .font(.system(size: 15))
                                    .foregroundColor(.black)
                            }
                        }
                        .padding()
                        .background(Color.white.opacity(0.3))
                        .cornerRadius(13)
                        
                        Button {
                            
                        } label: {
                            VStack {
                                Image("fame135")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 50)
                                Text(localizedkey: "abc_bmr")
                                    .font(.system(size: 15))
                                    .foregroundColor(.black)
                            }
                            .padding()
                            .background(Color.white.opacity(0.3))
                            .cornerRadius(13)
                        }
                        
                        Button {
                            
                        } label: {
                            VStack {
                                Image("fame221")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 50)
                                Text(localizedkey: "abc_body")
                                    .font(.system(size: 15))
                                    .foregroundColor(.black)
                            }
                            .padding()
                            .background(Color.white.opacity(0.3))
                            .cornerRadius(13)
                        }
                    })
                }
            }
            HamburgerMenuView(showMenu: $showMenu)
            
            AddWeight()
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                .padding()
        }
    }
}




#Preview {
    HealthWeight()
}
