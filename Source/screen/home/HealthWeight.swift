//
//  HealthWeight.swift
//  Health_Weight
//
//  Created by Boss on 09/06/2025.
//

import SwiftUI

struct HealthWeight: View {
    @EnvironmentObject var route: Router
    @State private var showMenu = false
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
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
                                .frame(width: 20, height: 15)
                                .padding()
                                .foregroundColor(.black)
                        }
                        
                        Spacer()
                        
                        Button {
                            
                        } label: {
                            Image("crown")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25, height: 25)
                                .padding()
                        }
                    }
                    
                    Text(localizedkey: "abc_welcome")
                        .font(.system(size: 15))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(30)
                        .bold()
                        .padding(.top, -42)
                    
                    dailyWeght()
                    
                    Text(localizedkey: "abc_filtness")
                        .font(.system(size: 17))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .padding(.top, -30)
                    
                    LazyVGrid(columns: columns, spacing: 10) {
                        
                        gridButton(image: "fame", text: localizedkey("abc_bmi")) {
                            route.navigateTo(.managebmicalcuator)
                        }
                        
                        gridButton(image: "fame126", text: localizedkey("abc_calorice")) {
                            route.navigateTo(.caloriecalculator)
                        }
                        
                        gridButton(image: "fame135", text: localizedkey("abc_bmrr")) {
                            route.navigateTo(.managebmrcalcuator)
                        }
                        
                        gridButton(image: "fame221", text: localizedkey("abc_body")) {
                            route.navigateTo(.managrboyfat)
                        }
                        
                    }
                    .padding(.horizontal)
                    
                    HStack(spacing: 16) {
                        smallGridButton(image: "fame2", text: localizedkey("abc_idealweight")) {
                            route.navigateTo(.manageidealweight)
                        }
                        
                        smallGridButton(image: "fame3", text: localizedkey("abc_leanbody")) {
                            route.navigateTo(.manageleanboy)
                        }
                        
                        smallGridButton(image: "fame4", text: localizedkey("abc_health")) {
                            route.navigateTo(.manageHealthyWeight)
                        }
                    }
                    
                    HStack(spacing: 16) {
                        smallGridButton(image: "fame5", text: localizedkey("abc_army")) {
                            route.navigateTo(.managearmybodyfat)
                        }
                        
                        smallGridButton(image: "fame6", text: localizedkey("abc_calorie")) {
                            route.navigateTo(.managecaloriesburned)
                        }       
                    }
                }
            }
            
            HamburgerMenuView(showMenu: $showMenu)
            
            Add()
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                .padding()
        }
    }
}

func localizedkey(_ key: String) -> String {
    NSLocalizedString(key, comment: "")
}

func gridButton(image: String, text: String, action: @escaping () -> Void) -> some View {
    Button(action: action) {
        VStack {
            Image(image)
                .resizable()
                .scaledToFit()
                .frame(height: 30)
            Text(text)
                .font(.system(size: 12))
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.white.opacity(0.3))
        .cornerRadius(13)
    }
}

func smallGridButton(image: String, text: String, action: @escaping () -> Void) -> some View {
    Button(action: action) {
        VStack(spacing: 4) {
            Image(image)
                .resizable()
                .scaledToFit()
                .frame(height: 20)
            
            Text(text)
                .font(.system(size: 10))
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
                .frame(height: 30)
        }
        .frame(width: 100, height: 80)
        .background(Color.white.opacity(0.3))
        .cornerRadius(12)
    }
}

struct dailyWeght: View {
    @EnvironmentObject var route: Router
    
    var body: some View {
        HStack {
            VStack {
                Button {
                    
                } label: {
                    HStack {
                        Text(localizedkey: "abc_daily")
                            .font(.system(size: 15))
                            .foregroundColor(.black)
                            .bold()
                        Image("hicon")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                Button {
                    route.navigateTo(.add)
                } label: {
                    HStack {
                        Image("scales")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                        Text(localizedkey: "abc_currentWeight")
                            .foregroundStyle(Color.black)
                            .font(.system(size: 13))
                        Text("62 kg")
                            .font(.system(size: 15))
                            .foregroundStyle(Color.black)
                            .bold()
                        Text("-1.0")
                            .padding(5)
                            .foregroundStyle(.white)
                            .background(Color.red)
                            .cornerRadius(5)
                            .font(.system(size: 15))
                    }
                }
                
                Button {
                    
                } label: {
                    HStack {
                        Image("goal")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                        Text(localizedkey: "abc_taggetWeight")
                            .foregroundStyle(Color.black)
                            .font(.system(size: 13))
                        Text("68 kg")
                            .font(.system(size: 15))
                            .foregroundStyle(Color.black)
                            .bold()
                        Text("+6.0")
                            .padding(5)
                            .foregroundStyle(.white)
                            .background(Color.green)
                            .cornerRadius(5)
                            .font(.system(size: 15))
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
    }
}


#Preview {
    HealthWeight()
}
