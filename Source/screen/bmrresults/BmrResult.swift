//
//  BmrResult.swift
//  Health_Weight
//
//  Created by Boss on 20/06/2025.
//

import SwiftUI

struct BmrResult: View {
    @EnvironmentObject var route: Router
        
    var body: some View {
        VStack {
            toobal()
            
            ScrollView {
                Image("Image9")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300)
                
                bmrResult()
            }
            
            buttonBmr()
            Spacer()
        }
    }
    
    func toobal() -> some View {
        HStack {
            Button {
                route.navigateBack()
            } label: {
                Image(systemName: "arrow.left")
                    .font(.title)
                    .foregroundColor(.black)
            }
            Spacer()
            
            Text(localizedkey: "abc_bmrresult")
                .foregroundStyle(Color.black)
                .font(.title2)
                .frame(maxWidth: .infinity)
                .bold()
                .padding(.leading, -42)
        }
        .padding()
    }
    
    func bmrResult() -> some View {
        VStack {
            Text("BMR: 1,413 Calories/day")
                .font(.title2)
                .bold()
            Text(localizedkey: "abc_textbmr")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 18))
                .padding(10)
            HStack {
                Text("Activity Level")
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(Color.green)
                    .cornerRadius(12)
                Text("Calorie")
                    .bold()
                    .frame(width: 80)
                    .padding()
                    .background(Color.green)
                    .cornerRadius(12)
            }
            .padding(10)
            .padding(.top, -15)
            
            HStack {
                Text("Sedentary: little or no exercise")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(Color.gray.opacity(0.3))
                    .cornerRadius(12)
                    .font(.system(size: 16))
                
                Text("1,802")
                    .bold()
                    .frame(width: 80)
                    .padding()
                    .background(Color.gray.opacity(0.3))
                    .cornerRadius(12)
            }
            .padding(10)
            .padding(.top, -10)
            
            HStack {
                Text("Exercies 1-3 times/week")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(Color.gray.opacity(0.3))
                    .cornerRadius(12)
                    .font(.system(size: 16))
                
                Text("1,752")
                    .bold()
                    .frame(width: 80)
                    .padding()
                    .background(Color.gray.opacity(0.3))
                    .cornerRadius(12)
            }
            .padding(10)
            .padding(.top, -10)

            HStack {
                Text("Exercies 4-5 times/week")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(Color.gray.opacity(0.3))
                    .cornerRadius(12)
                    .font(.system(size: 16))
                
                Text("2,752")
                    .bold()
                    .frame(width: 80)
                    .padding()
                    .background(Color.gray.opacity(0.3))
                    .cornerRadius(12)
            }
            .padding(10)
            .padding(.top, -10)

            HStack {
                Text("Daily exercise or intense exercise 3-4 times/week")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(Color.gray.opacity(0.3))
                    .cornerRadius(12)
                    .font(.system(size: 16))
                
                Text("2,199")
                    .bold()
                    .frame(width: 80)
                    .padding()
                    .background(Color.gray.opacity(0.3))
                    .cornerRadius(12)
            }
            .padding(10)
            .padding(.top, -10)
            
            HStack {
                Text("Intense exercise 6-7 times/week")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(Color.gray.opacity(0.3))
                    .cornerRadius(12)
                    .font(.system(size: 16))
                
                Text("2,447")
                    .bold()
                    .frame(width: 80)
                    .padding()
                    .background(Color.gray.opacity(0.3))
                    .cornerRadius(12)
            }
            .padding(10)
            .padding(.top, -10)
            
            HStack {
                Text("Very intense exercise daily,or physical job")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(Color.gray.opacity(0.3))
                    .cornerRadius(12)
                    .font(.system(size: 16))
                
                Text("2,696")
                    .bold()
                    .frame(width: 80)
                    .padding()
                    .background(Color.gray.opacity(0.3))
                    .cornerRadius(12)
            }
            .padding(10)
            .padding(.top, -10)
            
            VStack {
                HStack {
                    Text(localizedkey: "abc_textexercise")
                        .bold()
                        .font(.system(size: 13))
                    Text(localizedkey: "abc_exercise")
                        .font(.system(size: 13))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                HStack {
                    Text(localizedkey: "abc_textIntense")
                        .bold()
                        .font(.system(size: 13))
                    Text(localizedkey: "abc_Intense")
                        .font(.system(size: 13))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                HStack {
                    Text(localizedkey: "abc_very")
                        .bold()
                        .font(.system(size: 13))
                    Text(localizedkey: "abc_verintense")
                        .font(.system(size:13))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
    
    func buttonBmr() -> some View {
        HStack {
            Button {
                route.navigateBack()
            } label: {
                Text(localizedkey: "abc_tryAgain")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .foregroundStyle(Color.white)
                    .bold()
                    .background(Color.green)
                    .cornerRadius(13)
            }
           
            Button {
                route.navigateTo(.home)
            } label: {
                Text(localizedkey: "abc_home")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.black)
                    .bold()
                    .background(Color.gray)
                    .cornerRadius(13)
            }
        }
        .padding(10)
    }
}

#Preview {
    BmrResult()
}
