//
//  CalorieBurnedByDistance.swift
//  Health_Weight
//
//  Created by Boss on 30/06/2025.
//

import SwiftUI

struct CalorieBurnedByDistance: View {
    @EnvironmentObject var route: Router
    
    @State private var isShowWRC = false
    @State private var isShowSP = false
    @State private var isShowDailog = false
    @State private var isShowDistance = false
    @State private  var isShowKP = false
    
    @State private var metWrc = 1.0
    @State private var speedPace = 4.2
    @State private var metSp = 1.0
    @State private var distance = 7.2
    @State private var boykg = 73.5
    @State private var metDistance = 1.0
    @State private  var metkp = 1.0
    
    @State private var editingField: EditingField = .none
    @State private var selectionDailog = "Select One"
    @State private var selectedActivity = ""
    @State private var selectSp = ""
    @State private var textDistance = ""
    @State private var textKp = ""
    
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    enum EditingField {
        case none, speed, distance, body
    }
    let small = [ "slow", "morderate", "fast", "very_fast"]
    
    let activitysmall: [String : Double] = [
        "slow": 3.221,
        "morderate": 4.509,
        "fast": 5.636,
        "very_fast": 6.441
    ]
    
    var body: some View {
        ZStack {
            VStack {
                Text("Activity")
                    .font(.system(size: 17))
                
                Button {
                    isShowWRC = true
                } label: {
                    HStack {
                        Text(selectionDailog)
                            .foregroundStyle(Color.black)
                        Spacer()
                        Image(systemName: "arrowtriangle.down.fill")
                            .foregroundColor(.black)
                    }
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(12)
                }
                .padding()
                .padding(.top, -20)
                
                Text("Speed/Pace")
                    .font(.system(size: 17))
                    .padding(.top, -10)
                
                HStack {
                    stepperBox(value: $speedPace, field: .speed)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(12)
                    
                    Button {
                        isShowSP = true
                    } label: {
                        HStack {
                            Text(selectedActivity)
                                .foregroundStyle(Color.black)
                                .font(.system(size: 15))
                            Spacer()
                            Image(systemName: "arrowtriangle.down.fill")
                                .foregroundColor(.black)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(12)
                    }
                }
                .padding()
                .padding(.top, -10)
                
                HStack {
                    ForEach(small, id: \.self) { list in
                        Button {
                            selectSp = list
                            if let newValue = activitysmall[list] {
                                speedPace = newValue
                            }
                        } label: {
                            Text(list)
                                .padding(5)
                                .font(.system(size: 12))
                                .foregroundStyle(.green)
                                .bold()
                                .overlay(
                                    RoundedRectangle(
                                        cornerRadius: 7)
                                    .stroke(Color.green, lineWidth: 2)
                                )
                        }
                    }
                }
                .padding(.top, -10)
                .padding(.leading, 120)
                
                Text("Distance")
                    .font(.system(size: 17))
                
                HStack {
                    stepperBox(value: $distance, field: .distance)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(12)
                    
                    Button {
                        isShowDistance = true
                    } label: {
                        HStack {
                            Text(textDistance)
                                .foregroundStyle(Color.black)
                                .font(.system(size: 15))
                            Spacer()
                            Image(systemName: "arrowtriangle.down.fill")
                                .foregroundColor(.black)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(12)
                    }
                }
                .padding()
                .padding(.top, -15)
                
                Text("Body Weight")
                    .font(.system(size: 17))
                    .padding(.top, -12)
                
                HStack {
                    stepperBox(value: $boykg, field: .body)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(12)
                    
                    Button {
                        isShowKP = true
                    } label: {
                        HStack {
                            Text(textKp)
                                .foregroundStyle(Color.black)
                                .font(.system(size: 15))
                            Spacer()
                            Image(systemName: "arrowtriangle.down.fill")
                                .foregroundColor(.black)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(12)
                    }
                }
                .padding()
                .padding(.top, -15)
                
                Spacer()
                buttnCalculate()
            }
            
            if isShowWRC {
                DailogWRC(isShowWRC: $isShowWRC, textWRC: $selectionDailog, metWrc: $metWrc)
            }
            
            if isShowSP {
                DailogSP(isShowSP: $isShowSP, textSp: $selectedActivity, metSp: $metSp)
            }
            
            if isShowDistance {
                DailogDistance(isShowDistance: $isShowDistance, textDistance: $textDistance, metDistance: $metDistance)
            }
            
            if isShowKP {
                DailogKP(isShowKP: $isShowKP, textKp: $textKp, metkp: $metkp)
            }
            
            ChooseWeight(isShowDialog: $isShowDailog, input: $selectSp)
                .onChange(of: isShowDailog) { newValue in
                    if !newValue {
                        DispatchQueue.main.async {
                            if let value = Double(selectSp) {
                                switch editingField {
                                case .speed:
                                    speedPace = Double(value)
                                case .distance:
                                    distance = Double(value)
                                case .body:
                                    boykg = Double(value)
                                default: break
                                }
                            }
                            editingField = .none
                        }
                    }
                }
        }
        Spacer()
        
            .onAppear {
                if selectedActivity.isEmpty {
                    selectedActivity = "minutes per mile"
                    metSp = 9.8
                }
                if textDistance.isEmpty {
                    textDistance = "miles"
                    metDistance = 1.036
                }
                if textKp.isEmpty {
                    textKp = "pounds"
                    metkp = 0.453592
                }
            }
    }
    
    func buttnCalculate() -> some View {
        Button {
            calculateCalories()
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
        // Kiểm tra dữ liệu đầu vào
        if selectionDailog == "Select One" {
            alertMessage = "Please select an activity."
            showAlert = true
            return
        }

        if selectedActivity.isEmpty {
            alertMessage = "Please select a speed/pace unit."
            showAlert = true
            return
        }

        if textDistance.isEmpty {
            alertMessage = "Please select a distance unit."
            showAlert = true
            return
        }

        if textKp.isEmpty {
            alertMessage = "Please select a weight unit."
            showAlert = true
            return
        }

        // Giới hạn kiểm tra cân nặng
        if textKp == "pounds" && (boykg < 80 || boykg > 350) {
            alertMessage = "Weight must be between 80 and 350 pounds."
            showAlert = true
            return
        }

        if textKp == "kilograms" && (boykg < 35 || boykg > 160) {
            alertMessage = "Weight must be between 35 and 160 kilograms."
            showAlert = true
            return
        }

        // Kiểm tra khoảng cách > 0
        if distance <= 0 {
            alertMessage = "Distance must be greater than 0."
            showAlert = true
            return
        }
        
        //Kiểm tra speed/pace
        if speedPace <= 0.8 || speedPace > 13 {
            alertMessage = "Speed kilometers per hour exceeds 13 and must be greater than 0.8!"
            showAlert = true
            return
        }

        // Kiểm tra tốc độ > 0
        if speedPace <= 0 {
            alertMessage = "Speed/Pace must be greater than 0."
            showAlert = true
            return
        }

        // Tính toán calories
        let weightKg = boykg * metkp        // convert về kg
        let distMiles = distance * metDistance
        let metValue = metWrc + metSp       // Tổng hợp MET
        let calories = metValue * weightKg * distMiles * 0.0175

        // Chuyển sang màn kết quả
        route.navigateTo(.resultcalories(resultCalories: calories))
    }

    
    private func stepperBox(value: Binding<Double>, field: EditingField) -> some View {
        Text(String(format: "%.1f", value.wrappedValue))
            .font(.system(size: 15))
            .frame(width: 70)
            .cornerRadius(8)
            .onTapGesture {
                selectSp = "\(value.wrappedValue)"
                editingField = field
                isShowDailog = true
            }
    }
}

#Preview {
    CalorieBurnedByDistance()
}
