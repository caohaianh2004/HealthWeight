//
//  HealthWeight.swift
//  Health_Weight
//
//  Created by Boss on 09/06/2025.
//

import SwiftUI
import Charts

struct HealthWeight: View {
    @EnvironmentObject var route: Router
    @State private var showMenu = false
    @State private var history: [HistoryObject] = []
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        let showFame2 = loadTabState(key: "show_fame2")
        let showFame3 = loadTabState(key: "show_fame3")
        let showFame4 = loadTabState(key: "show_fame4")
        let showFame5 = loadTabState(key: "show_fame5")
        let showFame6 = loadTabState(key: "show_fame6")
        
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
                    
                    VStack {
                        Button {
                            route.navigateTo(.history)
                        } label: {
                            HStack {
                                Text("7-day weight history")
                                    .foregroundStyle(Color.black)
                                
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.black)
                            }
                            .padding(5)
                        }
                        Chart {
                            ForEach(last7DaysWithData, id: \.date) { entry in
                                LineMark(
                                    x: .value("Date", entry.date),
                                    y: .value("Weight", entry.weight)
                                )
                                .interpolationMethod(.monotone)
                                .foregroundStyle(.blue)
                                
                                PointMark(
                                    x: .value("Date", entry.date),
                                    y: .value("Weight", entry.weight)
                                )
                                .foregroundStyle(entry.weight == 0 ? .gray.opacity(0.4) : .red)
                                
                                RuleMark(x: .value("Date", entry.date))
                                    .foregroundStyle(Color.gray.opacity(0.3))
                            }
                        }
                    }
                    .chartXAxis {
                        AxisMarks(values: .stride(by: .day)) { value in
                            AxisGridLine()
                            AxisTick()
                            AxisValueLabel(format: .dateTime.day().month(), centered: true)
                                .font(.system(size: 10))
                                .foregroundStyle(.black.opacity(0.3))
                        }
                    }
                    .chartYAxis {
                        AxisMarks(position: .leading)
                    }
                    .frame(height: 250)
                    .padding()
                    .background(Color.white.opacity(0.8))
                    .cornerRadius(12)
                    .shadow(radius: 3)
                    .padding(.horizontal)
                    
                    Text(localizedkey: "abc_filtness")
                        .font(.system(size: 17))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .padding(.top, -10)
                    
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
                    
                    
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                        if showFame2 {
                            smallGridButton(image: "fame2", text: "Ideal Weight") {
                                route.navigateTo(.manageidealweight)
                            }
                        }
                        if showFame3 {
                            smallGridButton(image: "fame3", text: "Lean Body") {
                                route.navigateTo(.manageleanboy)
                            }
                        }
                        if showFame4 {
                            smallGridButton(image: "fame4", text: "Healthy Weight") {
                                route.navigateTo(.manageHealthyWeight)
                            }
                        }
                        if showFame5 {
                            smallGridButton(image: "fame5", text: "Army Body Fat") {
                                route.navigateTo(.managearmybodyfat)
                            }
                        }
                        if showFame6 {
                            smallGridButton(image: "fame6", text: "Calories Burned") {
                                route.navigateTo(.managecaloriesburned)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                
                .onAppear {
                    history = DatabaseData.shared.getHistory(forDays: 7)
                }
            }
            
            HamburgerMenuView(showMenu: $showMenu)
            
            Add()
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                .padding()
        }
    }
    
    /// Trả về 7 ngày gần nhất và dữ liệu nếu có, nếu không có thì weight = 0
    var last7DaysWithData: [(date: Date, weight: Double)] {
        let today = Calendar.current.startOfDay(for: Date())
        let past7Dates = (0..<7).map { Calendar.current.date(byAdding: .day, value: -$0, to: today)! }
        let formatted = past7Dates.map { Calendar.current.startOfDay(for: $0) }
        
        // Group dữ liệu theo ngày
        let grouped = Dictionary(grouping: history) { Calendar.current.startOfDay(for: toDate($0.time) ?? Date.distantPast) }
        
        // Trả về mảng tuple
        return formatted.reversed().map { day in
            if let item = grouped[day]?.first {
                return (date: day, weight: Double(item.weightKg))
            } else {
                return (date: day, weight: 0)
            }
        }
    }
    
    func toDate(_ time: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter.date(from: time)
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
                    route.navigateTo(.weighttracker)
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
                    route.navigateTo(.weighttracker)
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
