//
//  EditProfileScreen.swift
//  Health_Weight
//
//  Created by Boss on 04/06/2025.
//

import SwiftUI

struct ManaEditProfileScreen: View {
    @EnvironmentObject var route: Router
    @State private var selectionTab = 0
    @State private var image = "Image6"
    @State private var weight = 60.1
    @State private var height = 170
    @State private var age = 25
    @State private var heightCm: Double = 175.0
    @State private var weightgoal = 65.4
    @State private var selectedHeight: Double = 4.0
    @State private var selectionValue: Double = 6.5
    @State private var selectionGender: MetricUnits.Gender = .man


    var body: some View {
        VStack {
            HStack {
                Button {
                    route.navigateBack()
                } label: {
                    Image(systemName: "arrow.left")
                        .font(.title)
                        .foregroundColor(.black)
                }
                
                Spacer()
                
                Text(localizedkey:"abc_create_your_profile")
                    .font(.system(size: 20))
                    .bold()
                    .frame(maxWidth: .infinity)
                    .padding(.leading, 40)
                
                Spacer()
                
                Button {
                    let db = DatabasePeople()
                    var heightToSave = heightCm
                    var heightFt = 0.0
                    var heightIn = 0.0
                    
                    if selectionTab == 1 {
                    heightFt = selectedHeight
                        heightIn = selectionValue
                        heightToSave = (heightFt * 30.48) + (heightIn * 2.54)
                    }
                    
                    let person = Person(
                        image: image,
                        heightCm: heightCm,
                        weightKg: weight,
                        age: age,
                        targetWeightLb: weightgoal,
                        heightFt: heightFt,
                        heightln: heightIn,
                        weightLb: weight
                    )
                    
                        
                    db.addPerson(person)
                    route.navigateTo(.home)
                } label: {
                    Text(localizedkey: "abc_next")
                        .frame(width: 80, height: 40)
                        .foregroundColor(.white)
                        .bold()
                        .background(Color.green)
                        .cornerRadius(10)
                }
            }
            .padding(10)
            
            HStack(spacing: 0) {
                ForEach(["US Units", "Metric Units"], id: \.self) { title in
                    Button {
                        selectionTab = title == "Metric Units" ? 0 : 1
                    } label: {
                        Text(title)
                            .padding(5)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 8)
                            .font(.system(size: 13))
                            .bold()
                            .background(selectionTab == (title == "Metric Units" ? 0 : 1) ? Color.green : Color.gray.opacity(0.2))
                            .foregroundStyle(selectionTab == (title == "Metric Units" ? 0 : 1) ? Color.white : Color.black)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                    .padding(5)
                }
            }
            .padding()
            
            Group {
                if selectionTab == 1 {
                    UsUnits(height: $height, age: $age, weight: $weight, weightgoal: $weightgoal, selectedHeight: $selectedHeight, selectionValue: $selectionValue)
                } else {
                    MetricUnits(heightCm: $heightCm, age: $age, weight: $weight, weightgoal: $weightgoal, image: $image)
                }
            }
        }
        .onAppear {
            let db = DatabasePeople()
            let people = db.getPerson()
            if let person = people.first {
                image = person.image
                heightCm = person.heightCm
                weight = person.weightKg
                age = person.age
                weightgoal = person.targetWeightLb
            print("✅ Đã cập nhật dữ liệu mới")
            } else {
            print("🚨 Dữ liệu cũ chưa được cập nhật")
            }
        }
    }
}

#Preview {
        ManaEditProfileScreen()
}
