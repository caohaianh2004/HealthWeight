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
                    
                    HStack {
                        Button {
                            route.navigateTo(.managebmicalcuator)
                        } label: {
                            VStack {
                                Image("fame")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 130, height: 40)
                                Text(localizedkey: "abc_bmi")
                                    .font(.system(size: 13))
                                    .foregroundColor(.black)
                            }
                            .padding()
                            .background(Color.white.opacity(0.3))
                            .cornerRadius(13)
                        }
                        
                        Button {
                            route.navigateTo(.caloriecalculator)
                        } label: {
                            VStack {
                                Image("fame126")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 130, height: 40)
                                Text(localizedkey: "abc_calorice")
                                    .font(.system(size: 13))
                                    .foregroundColor(.black)
                            }
                        }
                        .padding()
                        .background(Color.white.opacity(0.3))
                        .cornerRadius(13)
                    }
                        
                    HStack {
                        Button {
                            route.navigateTo(.managebmrcalcuator)
                        } label: {
                            VStack {
                                Image("fame135")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 130, height: 30)
                                Text(localizedkey: "abc_bmr")
                                    .font(.system(size: 13))
                                    .foregroundColor(.black)
                                    .frame(width: 65)
                            }
                            .padding()
                            .background(Color.white.opacity(0.3))
                            .cornerRadius(13)
                        }
                        
                        Button {
                            route.navigateTo(.managrboyfat)
                        } label: {
                            VStack {
                                Image("fame221")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 130, height: 30)
                                Text(localizedkey: "abc_body")
                                    .font(.system(size: 13))
                                    .foregroundColor(.black)
                                
                            }
                            .padding()
                            .background(Color.white.opacity(0.3))
                            .cornerRadius(13)
                        }
                    }
                    
                    HStack {
                        Button {
                            route.navigateTo(.manageidealweight)
                        } label: {
                            VStack {
                                Image("fame2")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 30)
                                Text(localizedkey: "abc_idealweight")
                                    .font(.system(size: 12))
                                    .foregroundColor(.black)
                                    .frame(width: 70)
                            }
                            .padding(10)
                            .background(Color.white.opacity(0.3))
                            .cornerRadius(13)
                        }
                        
                        Button {
                            route.navigateTo(.manageleanboy)
                        } label: {
                            VStack {
                                Image("fame3")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 30)
                                Text(localizedkey: "abc_leanbody")
                                    .font(.system(size: 12))
                                    .foregroundColor(.black)
                                    .frame(width: 70)
                            }
                            .padding(10)
                            .background(Color.white.opacity(0.3))
                            .cornerRadius(13)
                        }
                        
                        Button {
                            route.navigateTo(.manageHealthyWeight)
                        } label: {
                            VStack {
                                Image("fame4")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 30)
                                Text(localizedkey: "abc_health")
                                    .font(.system(size: 12))
                                    .foregroundColor(.black)
                                    .frame(width: 70)
                            }
                            .padding(10)
                            .background(Color.white.opacity(0.3))
                            .cornerRadius(13)
                        }
                    }
                    
                    HStack {
                        Button {
                            route.navigateTo(.managearmybodyfat)
                        } label: {
                            VStack {
                                Image("fame5")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 30)
                                Text(localizedkey: "abc_army")
                                    .font(.system(size: 12))
                                    .foregroundColor(.black)
                                    .frame(width: 70)
                            }
                            .padding(10)
                            .background(Color.white.opacity(0.3))
                            .cornerRadius(13)
                        }
                        
                        Button {
                            
                        } label: {
                            VStack {
                                Image("fame6")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 30)
                                Text(localizedkey: "abc_calorie")
                                    .font(.system(size: 12))
                                    .foregroundColor(.black)
                                    .frame(width: 70)
                            }
                            .padding(10)
                            .background(Color.white.opacity(0.3))
                            .cornerRadius(13)
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
