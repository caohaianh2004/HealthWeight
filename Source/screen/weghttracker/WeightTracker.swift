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
            
            HStack {
                HStack {
                    Text("70.1")
                    Text("kg")
                    Image(systemName: "pencil")
                }
                .font(.system(size: 13))
                .padding(.leading, 30)
                Spacer()
                
                HStack {
                    Text("62.5")
                    Text("kg")
                    Image(systemName: "pencil")
                }
                .font(.system(size: 13))
                .foregroundStyle(Color.green)
                Spacer()
                
                HStack {
                    Text("60.5")
                    Text("kg")
                    Image(systemName: "pencil")
                }
                .font(.system(size: 13))
            }
            .padding()
            .padding(.top, -40)
            
            HStack {
                ForEach(month, id: \.self) { list in
                    Button {
                        textWeight = list
                    } label: {
                        Text(list)
                            .foregroundStyle(textWeight == list ? Color.green : Color.gray)
                            .bold()
                            .font(.system(size: 14))
                    }
                    .padding()
                    .padding(.top, -20)
                    Spacer()
                }
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
            .frame(height: 150)
            .padding()
            .background(Color.white.opacity(0.9))
            .cornerRadius(12)
            .shadow(radius: 3)
            .padding(.horizontal)
            
            HStack {
                ForEach(textlist, id: \.self) { list in
                    Text(list)
                        .foregroundStyle(Color.black)
                        .font(.system(size: 13))
                }
                .padding()
            }
            Spacer()
            
            HStack {
                HStack {
                    Image(systemName: "arrow.up")
                    Text("+22")
                    Text("kg")
                }
                .font(.system(size: 13))
                
                Spacer()
                
                
                HStack {
                    Text("62.5")
                    Text("kg")
                }
                .font(.system(size: 13))
                .foregroundStyle(Color.green)
             
                Spacer()
                
                HStack {
                    Text("-30.5")
                    Text("kg")
                }
                .font(.system(size: 13))
                
                
            }
            .padding()
            .padding(.top, -40)
            
            ZStack {
                Image("control")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300)
                
                Image("needle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30)
                    .padding(.top, 20)
                //                    .rotationEffect(.degrees(needleAngle), anchor: .bottom)
                    .offset(y: -10)
            }
            
            Text("BMI = 15.9 kg/m2")
                .bold()
            Text("(Normal)")
                .foregroundStyle(Color.green)
                .bold()
            
            buttonthere()
            
        }
        .onAppear {
            history = DatabaseData.shared.getHistory(forDays: 7)
        }
        Spacer()
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

#Preview {
    WeightTracker()
}
