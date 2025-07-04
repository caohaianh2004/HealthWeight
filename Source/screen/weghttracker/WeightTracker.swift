//
//  WeightTracker.swift
//  Health_Weight
//
//  Created by Boss on 02/07/2025.
//

import SwiftUI
import Charts

struct WeightTracker: View {
    let weight = [
        "Start Weight",
        "Current Weight",
        "Target Weight"
    ]
    let textlist = [
        "Change",
        "Average",
        "Remaining"
    ]
    let month = [
        "2W", "1M" , "3M", "6M", "1Y", "ALL"
    ]
    @EnvironmentObject var route: Router
    @State private var textWeight = ""
    @State private var startWeigh: Double = .zero
    @State private var goalWeight: Double = .zero
    @StateObject private var viewModel = UserViewModel()
    @State private var history: [HistoryObject] = []
    @State private var stats = WeightStats()
    @State private var selectedTab = 1
    @State private var weightkg: Double = .zero
    @State private var weightlb: Double = .zero
    @State private var selectedRange: String = "2W"
    
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
                
                Text(localizedkey: "abc_weighttracker")
                    .font(.system(size: 18))
                    .bold()
                
                Spacer()
                
                Button {
                    ///Nhập nội dung
                } label: {
                    Image("crown")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 25)
                }
            }
            .padding()
            
            HStack {
                ForEach(weight, id: \.self) { weightkl in
                    Button {
                        textWeight = weightkl
                    } label: {
                        Text(weightkl)
                            .foregroundStyle(Color.black)
                            .font(.system(size: 13))
                    }
                    .padding()
                }
            }
            .padding(.top, -20)
            
            HStack {
                HStack {
                    Text(String(format: "%.1f", convertedWeight(stats.startWeight)))
                    Text(weightUnitLabel())
                    Image(systemName: "pencil")
                }
                
                .font(.system(size: 13))
                .padding(.leading, 30)
                
                Spacer()
                
                HStack {
                    Text(String(format: "%.1f", convertedWeight(stats.currentWeight)))
                    Text(weightUnitLabel())
                    Image(systemName: "pencil")
                }
                .font(.system(size: 13))
                .foregroundStyle(Color.green)
                
                Spacer()
                
                HStack {
                    Text(String(format: "%.1f", convertedWeight(stats.targetWeight)))
                    Text(weightUnitLabel())
                    Image(systemName: "pencil")
                }
                .font(.system(size: 13))
            }
            .padding()
            .padding(.top, -40)
 
            HStack {
                ForEach(month, id: \.self) { range in
                    Button {
                        selectedRange = range
                    } label: {
                        Text(range)
                            .font(.system(size: 14))
                            .fontWeight(.semibold)
                            .foregroundColor(selectedRange == range ? .green : .gray)
                    }
                    .padding(.horizontal, 6)
                    .padding(.vertical, 4)
                    .background(selectedRange == range ? Color.green.opacity(0.1) : Color.clear)
                    .clipShape(Capsule())
                }
            }
            .padding(5)
            .padding(.horizontal)
            
            Chart {
                ForEach(filteredData, id: \.date) { entry in
                    LineMark(
                        x: .value("Date", entry.date),
                        y: .value("Weight", convertedWeight(entry.weight))
                    )
                    .interpolationMethod(.monotone)
                    .foregroundStyle(.blue)
                    
                    PointMark(
                        x: .value("Date", entry.date),
                        y: .value("Weight", convertedWeight(entry.weight))
                    )
                    .foregroundStyle(entry.weight == 0 ? .gray.opacity(0.3) : .red)
                    
                    RuleMark(x: .value("Date", entry.date))
                        .foregroundStyle(Color.gray.opacity(0.2))
                }
            }
            .chartYAxis {
                AxisMarks(position: .leading)
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
            .chartYScale(domain: yAxisRange)
            .frame(height: 150)
            .padding()
            .background(Color.white.opacity(0.9))
            .cornerRadius(12)
            .shadow(radius: 3)
            .padding(.horizontal)
            
            
            
            HStack {
                VStack {
                    Text("Change")
                    Text(String(format: "%.1f \(weightUnitLabel())", convertedWeight(stats.change)))
                        .foregroundColor(stats.change >= 0 ? .green : .red)
                    
                }
                .font(.system(size: 13))
                Spacer()
                VStack {
                    Text("Average")
                    Text(String(format: "%.1f \(weightUnitLabel())", convertedWeight(stats.average)))
                }
                .font(.system(size: 13))
                Spacer()
                VStack {
                    Text("Remaining")
                    Text(String(format: "%.1f \(weightUnitLabel())", convertedWeight(stats.remaining)))
                        .foregroundColor(stats.remaining >= 0 ? .blue : .orange)
                }
                .font(.system(size: 13))
            }
            .padding()
            
            if let person = viewModel.people.first {
                MeasuringmachineUpdated(
                    weight: selectedTab == 0 ? weightlb : weightkg,
                    heightCm: person.heightCm,
                    heightFt: person.heightFt,
                    heightIn: person.heightln,
                    selectedTab: selectedTab
                )
            }
            
            buttonthere()
            
        }
        .onAppear {
            history = DatabaseData.shared.getHistory(forDays: 7)
        }
        .onAppear {
            let people = DatabasePeople.shared.getPerson()
            if let person = people.first {
                goalWeight = person.targetWeightLb   // hoặc .targetWeightKg nếu dùng metric
                let historyData = DatabaseData.shared.getHistory(forDays: 7)
                history = historyData
                
                // currentWeight là cân nặng mới nhất trong bảng data
                let currentWeight = Double(historyData.last?.weightKg ?? Float(person.weightKg))
                
                stats = calculateWeightStatsInline(
                    history: historyData,
                    currentWeight: currentWeight,
                    targetWeight: person.targetWeightLb // Nếu dùng US thì đổi sang targetWeightLb
                )
            }
        }
        .onAppear {
            selectedTab = UserDefaults.standard.integer(forKey: "selectedTab")
            viewModel.fetchPeople()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                if let person = viewModel.people.first {
                    weightkg = person.weightKg
                    weightlb = person.weightKg * 2.20462
                }
            }
        }
        
        Spacer()
    }
    
    var yAxisRange: ClosedRange<Double> {
        let values = filteredData.map { convertedWeight($0.weight) }
        let maxVal = values.max() ?? 0
        
        if maxVal <= 0 {
            return 0...10  // không có dữ liệu → giữ thang nhỏ
        } else {
            let paddedMax = ceil(maxVal / 10) * 10 + 10 // làm tròn lên
            return 0...paddedMax
        }
    }
    
    
    var filteredData: [(date: Date, weight: Double)] {
        let today = Calendar.current.startOfDay(for: Date())
        var days = 7
        
        switch selectedRange {
        case "1M": days = 30
        case "3M": days = 90
        case "6M": days = 180
        case "1Y": days = 365
        case "ALL": days = 730
        default: days = 7
        }
        
        let pastDates = (0..<days).map {
            Calendar.current.date(byAdding: .day, value: -$0, to: today)!
        }
        
        let formattedDates = pastDates.map { Calendar.current.startOfDay(for: $0) }
        
        let grouped = Dictionary(grouping: history) { Calendar.current.startOfDay(for: toDate($0.time) ?? Date.distantPast) }
        
        return formattedDates.reversed().map { day in
            if selectedRange == "2W", let item = grouped[day]?.first {
                return (date: day, weight: Double(item.weightKg))
            } else {
                // Từ 1M trở đi thì tất cả các điểm đều là 0 (nếu không có dữ liệu)
                return (date: day, weight: 0)
            }
        }
    }

    func convertedWeight(_ weight: Double) -> Double {
        return selectedTab == 0 ? weight * 2.20462 : weight
    }
    
    func weightUnitLabel() -> String {
        return selectedTab == 0 ? "lb" : "kg"
    }
    
    
    var last7DaysWithData: [(date: Date, weight: Double)] {
        let today = Calendar.current.startOfDay(for: Date())
        let past7Dates = (0..<7).map { Calendar.current.date(byAdding: .day, value: -$0, to: today)! }
        let formatted = past7Dates.map { Calendar.current.startOfDay(for: $0) }
        
        let grouped = Dictionary(grouping: history) { Calendar.current.startOfDay(for: toDate($0.time) ?? Date.distantPast) }
        
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
    
    func buttonthere() -> some View {
        ZStack {
            HStack(spacing: 80) {
                Button {
                    route.navigateTo(.history)
                } label: {
                    VStack(spacing: 4) {
                        Image(systemName: "calendar.badge.clock")
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                        Text("History")
                            .font(.system(size: 13))
                            .foregroundColor(.white)
                    }
                }
                
                Button {
                    route.navigateTo(.editProfile)
                } label: {
                    VStack(spacing: 4) {
                        Image(systemName: "person.crop.circle.fill")
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                        Text("Profile")
                            .font(.system(size: 13))
                            .foregroundColor(.white)
                    }
                    .padding(.leading, 62)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 30)
            .padding(.vertical, 14)
            .background(Color.green)
            .clipShape(Capsule())
            .shadow(radius: 2)
            .padding()
            
            
            Button {
                route.navigateTo(.add)
            } label: {
                ZStack {
                    Circle()
                        .fill(Color.white)
                        .frame(width: 70, height: 70)
                    
                    Text("+")
                        .font(.system(size: 32, weight: .bold))
                        .foregroundColor(Color.green)
                }
                .shadow(radius: 4)
            }
            .offset(y: -30) // đẩy nút lên trên nền xanh
        }
        .padding(.top, 10)
    }
}


struct WeightStats {
    var startWeight: Double = 0
    var currentWeight: Double = 0
    var targetWeight: Double = 0
    var change: Double = 0
    var average: Double = 0
    var remaining: Double = 0
}

func calculateWeightStatsInline(history: [HistoryObject], currentWeight: Double, targetWeight: Double) -> WeightStats {
    guard !history.isEmpty else {
        return WeightStats(
            startWeight: currentWeight,
            currentWeight: currentWeight,
            targetWeight: targetWeight,
            change: 0,
            average: currentWeight,
            remaining: targetWeight - currentWeight
        )
    }
    
    let start = Double(history.first?.weightKg ?? 0)
    let current = currentWeight
    let average = history.map { Double($0.weightKg) }.reduce(0, +) / Double(history.count)
    
    return WeightStats(
        startWeight: start,
        currentWeight: current,
        targetWeight: targetWeight,
        change: current - start,
        average: average,
        remaining: targetWeight - current
    )
}

#Preview {
    WeightTracker()
}



