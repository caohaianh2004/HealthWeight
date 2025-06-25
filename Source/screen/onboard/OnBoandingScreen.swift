//
//  OnBoandingScreen.swift
//  Health_Weight
//
//  Created by Boss on 04/06/2025.
//

import SwiftUI

struct OnBoandingScreen: View {
    @EnvironmentObject var router: Router
    @State private var selectionTab = 0

    var body: some View {

            VStack {
                TabView(selection: $selectionTab) {
                    VStack {
                        Image("Image1")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 308, height: 364)
                        Text("BMI apps are essential for \n tracking your health, calculating \n BMI from height and weight, and \n suggesting improvemets.")
                            .foregroundStyle(.black)
                            .multilineTextAlignment(.center)
                            .bold()
                            .font(.system(size: 15))
                    }
                    .tag(0)

                    VStack {
                        Image("Image")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 308, height: 363)
                        Text("Input your height and weight, and \n the app calculates your BMI, \n offering tailored health tips.")
                            .foregroundStyle(.black)
                            .multilineTextAlignment(.center)
                            .bold()
                            .font(.system(size: 15))
                    }
                    .tag(1)

                    VStack {
                        Image("Image2")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 308, height: 363)
                        Text("Regular BMI checks detect issues early, \n lower disease risks, and aid weight \n management.")
                            .foregroundStyle(.black)
                            .multilineTextAlignment(.center)
                            .bold()
                            .font(.system(size: 15))
                    }
                    .tag(2)
                }
                .tabViewStyle(.page(indexDisplayMode: .automatic))

                HStack {
                    Button {
                        if selectionTab > 0 {
                            selectionTab -= 1
                        }
                    } label: {
                        Text("Back")
                            .foregroundStyle(.gray)
                            .font(.system(size: 16))
                    }

                    Spacer()

                    ForEach(0..<3) { index in
                        Circle()
                            .fill(selectionTab == index ? .black : .gray)
                            .frame(width: 10, height: 10)
                    }

                    Spacer()

                    Button {
                        if selectionTab < 2 {
                            selectionTab += 1
                        } else {
                            UserDefaults.standard.set(true, forKey: KEY_FIRST_APP)
                            router.navigateTo(.editProfile)
                        }
                    } label: {
                        Text("Next")
                            .foregroundStyle(.green)
                            .font(.system(size: 16))
                    }

                }
                .padding()

            }
            
        }
    }

let KEY_FIRST_APP = "firstApp"


#Preview {
    RouterView {
        OnBoandingScreen()
    }
}

