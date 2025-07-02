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
    @State private var height = 165
    @State private var age = 31
    @State private var heightCm: Double = 175.0
    @State private var weightgoal = 65.4
    @State private var selectedHeight: Double = 4.0
    @State private var selectionValue: Double = 6.5
    @State private var selectionGender: Gender = .man
    @State private var weightlb = 200.4

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
                
                
                Text(localizedkey:"abc_create_your_profile")
                    .font(.system(size: 18))
                    .bold()
                    .frame(maxWidth: .infinity)
                    .padding(.leading, 30)
                
                Button {
                    UserDefaults.standard.set(selectionTab, forKey: "selectedTab")
                    
                    let db = DatabasePeople()
                    var heightToSave = heightCm
                    var heightFt = 0.0
                    var heightIn = 0.0
                    var weightToSaveKg = weight
                    var weightToSaveLb = weightlb

                    if selectionTab == 0 {
                        // US Units: lb → kg
                        heightFt = selectedHeight
                        heightIn = selectionValue
                        heightToSave = (heightFt * 30.48) + (heightIn * 2.54)
                        weightToSaveKg = weightlb / 2.20462
                    } else {
                        // Metric: kg → lb
                        weightToSaveLb = weight * 2.20462
                    }

                    let person = Person(
                        image: image,
                        heightCm: heightToSave,
                        weightKg: weightToSaveKg,
                        age: age,
                        targetWeightLb: weightgoal,
                        heightFt: heightFt,
                        heightln: heightIn,
                        weightLb: weightToSaveLb
                    )

                    db.addPerson(person)

                    // 👉 Ghi thêm vào bảng `data` cho HistoryWeight
                    let today = DateFormatter.localizedString(from: Date(), dateStyle: .short, timeStyle: .none)
                    let formattedDate = formatToYYYYMMDD(today)
                    DatabaseData.shared.addWeight(
                        time: formattedDate,
                        weightKg: weightToSaveKg,
                        weightLb: weightToSaveLb
                    )

                    route.navigateTo(.history)

                } label: {
                    Text(localizedkey: "abc_next")
                        .frame(width: 50, height: 40)
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
                        selectionTab = title == "US Units" ? 0 : 1
                    } label: {
                        Text(title)
                            .padding(5)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 8)
                            .font(.system(size: 13))
                            .bold()
                            .background(selectionTab == (title == "US Units" ? 0 : 1) ? Color.green : Color.gray.opacity(0.2))
                            .foregroundStyle(selectionTab == (title == "US Units" ? 0 : 1) ? Color.white : Color.black)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                    .padding(5)
                }
            }
            .padding()
            
            Group {
                if selectionTab == 0 {
                    UsUnits(gender: $selectionGender, height: $height, age: $age, weightlb: $weightlb, weightgoal: $weightgoal, selectedHeight: $selectedHeight, selectionValue: $selectionValue, image: $image)
                } else {
                    MetricUnits(gender: $selectionGender,heightCm: $heightCm, age: $age, weight: $weight, weightgoal: $weightgoal, image: $image)
                }
            }
        }
        .onAppear {
            if let saveTab = UserDefaults.standard.object(forKey: "selectedTab") as? Int {
                selectionTab = saveTab
            }
            let db = DatabasePeople()
            let people = db.getPerson()
            if let person = people.first {
                image = person.image
                heightCm = person.heightCm
                weight = person.weightKg
                weightlb = person.weightLb
                age = person.age
                weightgoal = person.targetWeightLb
            print("✅ Đã cập nhật dữ liệu mới")
            } else {
            print("🚨 Dữ liệu cũ chưa được cập nhật")
            }
        }
    }

    func formatToYYYYMMDD(_ dateStr: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        if let date = formatter.date(from: dateStr) {
            formatter.dateFormat = "yyyy-MM-dd"
            return formatter.string(from: date)
        }
        return dateStr
    }
}

#Preview {
    ManaEditProfileScreen()
}
