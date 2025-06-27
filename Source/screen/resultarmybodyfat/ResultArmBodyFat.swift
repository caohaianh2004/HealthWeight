//
//  ResultArmBodyFat.swift
//  Health_Weight
//
//  Created by Boss on 27/06/2025.
//

import SwiftUI

struct ResultArmBodyFat: View {
    @EnvironmentObject var route: Router
    let headers = ["Age", "Male", "Female"]
    let data = [
        ("17-20", "24%", "30%"),
        ("21-27", "26%", "32%"),
        ("28-39", "28%", "34%"),
        ("40 and over", "30%", "36%")
    ]
    let headerss = ["Age", "Male", "Female"]
     let datas: [(String, String, String)] = [
         ("17-20", "20%", "30%"),
         ("21-27", "22%", "32%"),
         ("28-39", "24%", "34%"),
         ("40 and over", "26%", "36%")
     ]
    let resultarm: Double
    @State private var animatedResult: Double = 0
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    route.navigateBack()
                } label: {
                    Image(systemName: "arrow.left")
                        .font(.title2)
                        .foregroundColor(.black)
                }
                Spacer()
                
                Text(localizedkey: "abc_resultarmy")
                    .font(.system(size: 18))
                    .bold()
                Spacer()
                Button {
                    
                } label: {
                    Image("information")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20)
                }
            }
            .padding()
            
            ScrollView {
               Image("bannerarmy")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250)
                
                VStack {
                    HStack {
                        Text(localizedkey: "abc_bodyfatt")
                            .font(.title2)
                            .bold()
                        Text(String(format: "%.1f", animatedResult))
                            .font(.title3)
                            .foregroundStyle(Color.green)
                            .bold()
                        Text("%")
                            .font(.title2)
                            .bold()
                    }
                    
                    Text(localizedkey: "abc_textarmy")
                        .padding(5)
                    
                    VStack(spacing: 10) {
                          HStack {
                              ForEach(headers, id: \.self) { text in
                                  Text(text)
                                      .frame(maxWidth: .infinity)
                                      .padding(10)
                                      .background(Color.green)
                                      .cornerRadius(10)
                              }
                          }
                          
                          ForEach(data, id: \.0) { row in
                              HStack {
                                  ForEach([row.0, row.1, row.2], id: \.self) { text in
                                      Text(text)
                                          .frame(maxWidth: .infinity)
                                          .padding(10)
                                          .font(.system(size: 15))
                                          .background(Color.gray.opacity(0.3))
                                          .cornerRadius(10)
                                  }
                              }
                          }
                      }
                      .padding()
                    
                    Text(localizedkey: "abc_armytext")
                    
                    VStack(spacing: 10) {
                            HStack {
                                ForEach(headerss, id: \.self) { text in
                                    Text(text)
                                        .frame(maxWidth: .infinity)
                                        .padding(10)
                                        .background(Color.green)
                                        .foregroundColor(.black)
                                        .cornerRadius(10)
                                }
                            }
                            
                            ForEach(datas, id: \.0) { row in
                                HStack {
                                    ForEach([row.0, row.1, row.2], id: \.self) { item in
                                        Text(item)
                                            .frame(maxWidth: .infinity)
                                            .padding(10)
                                            .font(.system(size: 15))
                                            .background(Color.gray.opacity(0.3))
                                            .cornerRadius(10)
                                    }
                                }
                            }
                        }
                        .padding()
                }
            }
            
            HStack {
                Button {
                    route.navigateBack()
                } label: {
                    Text(localizedkey: "abc_tryAgain")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(15)
                        .font(.system(size: 18))
                        .foregroundColor(.white)
                        .bold()
                }
                
                Button {
                    route.navigateTo(.home)
                } label: {
                    Text(localizedkey: "abc_home")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.gray.opacity(0.4))
                        .cornerRadius(15)
                        .font(.system(size: 18))
                        .foregroundColor(.black)
                        .bold()
                }
            }
            .padding(10)
        }
        .onAppear {
            animatedResult = 0
            Timer.scheduledTimer(withTimeInterval: 0.02, repeats: true) { timer in
                if animatedResult < resultarm {
                    animatedResult += 0.5
                } else {
                    animatedResult = resultarm
                    timer.invalidate()
                }
            }
        }

    }
}

//#Preview {
//    ResultArmBodyFat()
//}
