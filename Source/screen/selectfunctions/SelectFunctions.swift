//
//  SelectFunctions.swift
//  Health_Weight
//
//  Created by Boss on 06/06/2025.
//

import SwiftUI

struct SelectFunctions: View {
    @EnvironmentObject var route: Router
    
    @State private var selection4 = loadTabState(key: "show_fame2")
    @State private var selection5 = loadTabState(key: "show_fame3")
    @State private var selection6 = loadTabState(key: "show_fame4")
    @State private var selection7 = loadTabState(key: "show_fame5")
    @State private var selection8 = loadTabState(key: "show_fame6")
    
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
                
                Text(localizedkey: "abc_selection")
                    .font(.system(size: 18))
                    .bold()
                    .frame(maxWidth: .infinity)
                    .padding(.leading, -30)
            }
            .padding(10)
     
                VStack {
                    HStack {
                        Image("fame")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25)
                        Text("bmi calculator").textCase(.uppercase)
                            .font(.system(size: 13))
                        
                        Spacer()
                        
                            Image(systemName: "circle.circle.fill")
                            .foregroundStyle(Color.black.opacity(0.2))
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(4)
                    
                    HStack {
                        Image("fame126")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25)
                        Text("calorie calculator").textCase(.uppercase)
                            .font(.system(size: 13))
                        
                        Spacer()

                            Image(systemName:"circle.circle.fill")
                            .foregroundStyle(Color.black.opacity(0.2))

                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(4)
                    
                    HStack {
                        Image("fame7")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25)
                        Text("bmr calculator").textCase(.uppercase)
                            .font(.system(size: 13))
                        
                        Spacer()
          
                            Image(systemName: "circle.circle.fill")
                            .foregroundStyle(Color.black.opacity(0.2))
                        }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(4)
                    
                    HStack {
                        Image("fame221")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25)
                        Text("body fat calculator").textCase(.uppercase)
                            .font(.system(size: 13))
                        
                        Spacer()
                        
                        Image(systemName: "circle.circle.fill")
                            .foregroundStyle(Color.black.opacity(0.2))
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(4)
                    
                    tabToggle(name: "Ideal Weight", image: "fame2", isOn: $selection4, key: "show_fame2")
                    tabToggle(name: "Lean Body", image: "fame3", isOn: $selection5, key: "show_fame3")
                    tabToggle(name: "Healthy Weight", image: "fame4", isOn: $selection6, key: "show_fame4")
                    tabToggle(name: "Army Body Fat", image: "fame5", isOn: $selection7, key: "show_fame5")
                    tabToggle(name: "Calories Burned", image: "fame6", isOn: $selection8, key: "show_fame6")
                    
                }
                .padding()
        }
        Spacer()
    }
    
    func tabToggle(name: String, image: String, isOn: Binding<Bool>, key: String) -> some View {
        HStack {
            Image(image)
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
            Text(name)
                .textCase(.uppercase)
                .font(.system(size: 13))
            Spacer()
            Button {
                isOn.wrappedValue.toggle()
                saveTabState(key: key, value: isOn.wrappedValue)
            } label: {
                Image(systemName: isOn.wrappedValue ? "circle.circle.fill" : "circle.circle")
                    .foregroundColor(.black)
            }
        }
        .padding(4)
    }
}

#Preview {
    SelectFunctions()
}
