//
//  CaloriesBurned.swift
//  Health_Weight
//
//  Created by Boss on 30/06/2025.
//

import SwiftUI

struct CaloriesBurned: View {
    let bodyweight = [
        "Kilograms", "pounds"
    ]
    
    enum EditingField {
        case none, hours, minutes, body
    }
    @EnvironmentObject var route: Router
    @State private var selectedText = "Select One"
    @State private var isShowActivy = false
    @State private var isShowDailog = false
    
    @State private var isShowWRCS = false
    @State private var isShowGym = false
    @State private var isShowTraining = false
    @State private var isShowOutdoor = false
    @State private var isShowHome = false
    
    @State private var selectedActivity = ""
    @State private var hours: Double = .zero
    @State private var minutes: Int = 45
    @State private var bodykg: Double = 70.0
    @State private var editingField: EditingField = .none
    @State private var kp = "Kilograms"
    
    @State private var met: Double = 1.0
    @State private var metHome: Double = 1.0
    @State private var metGym: Double = 1.0
    @State private var metTraining: Double = 1.0
    @State private var metValueW: Double = 1.0
    
    @State private var result: Double? = nil
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        ZStack {
            VStack(spacing: 16) {
                Text("Activity")
                
                Button {
                    isShowActivy = true
                } label: {
                    HStack {
                        Text(selectedText)
                            .foregroundStyle(Color.black)
                        Spacer()
                        Image(systemName: "arrowtriangle.down.fill")
                            .foregroundColor(.black)
                    }
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(12)
                }
                
                // Nếu đã chọn chủ đề thì hiển thị khung chọn hoạt động con
                if selectedText != "Select One" {
                    Button {
                        switch selectedText {
                        case "Walking, Running, Cycling, Swimming":
                            isShowWRCS = true
                        case "Gym Activities":
                            isShowGym = true
                        case "Training and Sports Activities":
                            isShowTraining = true
                        case "Outdoor Activities":
                            isShowOutdoor = true
                        case "Home & Daily Life Activities":
                            isShowHome = true
                        default:
                            break
                        }
                    } label: {
                        HStack {
                            Text(selectedActivity.isEmpty ? "Select Activity" : selectedActivity)
                                .foregroundStyle(.black)
                            Spacer()
                            Image(systemName: "arrowtriangle.down.fill")
                                .foregroundColor(.black)
                        }
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(12)
                    }
                }
                
                Text("Duration")
                
                HStack {
                    stepperBoxhours(title: "hours", valueft: $hours, field: .hours)
                        .frame(maxWidth: .infinity)
                        .padding(15)
                        .background(Color.gray.opacity(0.5))
                        .cornerRadius(12)
                    
                    stepperBoxminutes(title: "minutes", valueft: $minutes, field: .minutes)
                        .frame(maxWidth: .infinity)
                        .padding(15)
                        .background(Color.gray.opacity(0.5))
                        .cornerRadius(12)
                }
                
                Text("Body Weight")
                
                HStack {
                    stepperBoxhours(title: "", valueft: $bodykg, field: .body)
                        .frame(maxWidth: .infinity)
                        .padding(15)
                        .background(Color.gray.opacity(0.5))
                        .cornerRadius(12)
                    VStack {
                        HStack {
                            ForEach(bodyweight, id: \.self) { boy in
                                Button {
                                    kp = boy
                                } label: {
                                    Image(systemName: kp == boy ? "circle.circle.fill" : "circle.circle")
                                        .foregroundColor(.black)
                                    Text(boy)
                                        .foregroundColor(.black)
                                        .font(.system(size: 13))
                                }
                            }
                            .padding(1)
                        }
                        Text("*80 - 350 pounds or 35 - 160 kgs")
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                    }
                }
                
                Spacer()
                
                buttnCalculate()
                
            }
            .onChange(of: selectedText) { _ in
                selectedActivity = "Select One"
            }
            .padding()
            
            if isShowActivy {
                DailogActivity(
                    isActivitytext: $selectedText,
                    isShowActivy: $isShowActivy
                )
            }
            
            if isShowWRCS {
                DailogWRCS(
                    isShowWRCS: $isShowWRCS,
                    textWRCS: $selectedActivity,
                    metValueW: $metValueW
                )
            }
            
            if isShowGym {
                DailogGymActivites(
                    isShowGym: $isShowGym,
                    textGym: $selectedActivity,
                    metGym: $metGym
                )
            }
            
            if isShowTraining {
                DialogTrainingSports(
                    isShowTraingSports: $isShowTraining,
                    textView: $selectedActivity,
                    metTraining: $metTraining
                )
            }
            
            if isShowOutdoor {
                DialogOutdoor(
                    isShowOutdoor: $isShowOutdoor,
                    textOutdoor: $selectedActivity,
                    metValue: $met
                )
            }
            
            if isShowHome {
                DailogHome(
                    isShowHome: $isShowHome,
                    textHome: $selectedActivity,
                    metValue: $metHome
                )
            }
            
            ChooseWeight(isShowDialog: $isShowDailog, input: $kp)
                .onChange(of: isShowDailog) { newValue in
                    if !newValue {
                        DispatchQueue.main.async {
                            if let value = Double(kp) {
                                switch editingField {
                                case .hours:
                                    hours = Double(value)
                                case .minutes:
                                    minutes = Int(value)
                                case .body:
                                    bodykg = Double(value)
                                default: break
                                }
                            }
                            editingField = .none
                        }
                    }
                }
        }
    }
    
    
    func buttnCalculate() -> some View {
        Button {
            calculateCalories()
            if let result = result {
                route.navigateTo(.resultcalories(resultCalories: result))
            }
        } label: {
            Text(localizedkey: "abc_calculate")
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.green)
                .cornerRadius(13)
                .foregroundColor(.white)
                .bold()
        }
        .padding()
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("🚨Invalid Input"),
                message: Text(alertMessage),
                dismissButton: .default(Text("OK"))
            )
        }
    }
    
    func calculateCalories() {
        // Reset lại kết quả trước
        result = nil

        // Kiểm tra đã chọn nhóm hoạt động
        if selectedText == "Select One" {
            alertMessage = "Please select an activity group."
            showAlert = true
            return
        }

        // Kiểm tra đã chọn hoạt động cụ thể
        if selectedActivity.isEmpty || selectedActivity == "Select Activity" {
            alertMessage = "Please select a specific activity."
            showAlert = true
            return
        }

        // Kiểm tra đã chọn đơn vị cân nặng
        if kp.isEmpty {
            alertMessage = "Please select a weight unit (Kilograms or pounds)."
            showAlert = true
            return
        }

        // Kiểm tra giới hạn cân nặng
        if kp == "pounds" {
            if bodykg < 80 || bodykg > 350 {
                alertMessage = "Weight must be between 80 and 350 pounds."
                showAlert = true
                return
            }
        } else if kp == "Kilograms" {
            if bodykg < 35 || bodykg > 160 {
                alertMessage = "Weight must be between 35 and 160 kilograms."
                showAlert = true
                return
            }
        }
        
        // Kiểm tra giới hạn hours
        if hours <= 0 || hours > 24 {
            alertMessage = "Hours must be greater than 0 and not exceed 24."
            showAlert = true
            return
        }

        // Kiểm tra thời gian
        if hours <= 0 && minutes <= 0 {
            alertMessage = "Please enter the duration of activity."
            showAlert = true
            return
        }

        // Tính toán
        let weightKg = kp == "pounds" ? bodykg * 0.453592 : bodykg
        let totalHours = hours + Double(minutes) / 60.0

        let metValue: Double
        switch selectedText {
        case "Walking, Running, Cycling, Swimming":
            metValue = metValueW
        case "Gym Activities":
            metValue = metGym
        case "Training and Sports Activities":
            metValue = metTraining
        case "Outdoor Activities":
            metValue = met
        case "Home & Daily Life Activities":
            metValue = metHome
        default:
            metValue = 1.0
        }

        // Gán kết quả
        result = metValue * weightKg * totalHours
    }



    
    private func stepperBoxhours(title: String, valueft: Binding<Double>, field: EditingField) -> some View {
        HStack {
            Text(String(format: "%.1f", valueft.wrappedValue))
                .padding(5)
                .font(.system(size: 15))
                .frame(width: 70)
                .cornerRadius(8)
                .onTapGesture {
                    kp = "\(valueft.wrappedValue)"
                    editingField = field
                    isShowDailog = true
                }
            
            Text(title)
                .foregroundStyle(Color.gray)
        }
    }
    
    private func stepperBoxminutes(title: String, valueft: Binding<Int>, field: EditingField) -> some View {
        HStack {
            Text("\(valueft.wrappedValue)")
                .padding(5)
                .font(.system(size: 15))
                .frame(width: 70)
                .cornerRadius(8)
                .onTapGesture {
                    kp = "\(valueft.wrappedValue)"
                    editingField = field
                    isShowDailog = true
                }
            
            Text(title)
                .foregroundStyle(Color.gray)
        }
    }
    
    private func stepperButton(_ symbol: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Text(symbol)
                .frame(width: 35, height: 35)
                .background(Color.black.opacity(0.05))
                .cornerRadius(8)
        }
    }
}


#Preview {
    CaloriesBurned()
}
