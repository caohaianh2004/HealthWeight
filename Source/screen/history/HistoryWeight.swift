//
//  HistoryWeight.swift
//  Health_Weight
//
//  Created by Boss on 02/07/2025.
//

import SwiftUI

struct HistoryWeight: View {
    @EnvironmentObject var route: Router
    @State private var historyList: [HistoryObject] = []
    
    @State private var selectedItem: HistoryObject?
    @State private var showDialog = false
    @State private var weightDifferences: [Int: Float] = [:]
    
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
                   
                } label: {
                    Image("crown")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 25)
                }
            }
            .padding()
            
            ScrollView {
                VStack(alignment: .leading, spacing: 12) {
                    ForEach(historyList.indices, id: \.self) { index in
                        let item = historyList[index]
                        let previous = index < historyList.count - 1 ? historyList[index + 1] : nil
                        let diff = (weightDifferences[item.id] ?? item.weightKg) - (previous?.weightKg ?? item.weightKg)
                        
                        Button {
                            selectedItem = item
                            showDialog = true
                        } label: {
                            HStack {
                                Text(formatDate(from: item.time))
                                    .frame(width: 100, alignment: .leading)
                                    .font(.system(size: 16))
                                    .foregroundStyle(Color.black)
                                
                                Spacer()
                                
                                VStack(alignment: .trailing) {
                                    Text("\(String(format: "%.1f", item.weightKg)) kg")
                                        .font(.system(size: 16))
                                        .bold()
                                        .foregroundStyle(Color.black)
                                    
                                    Text("\(String(format: "%.1f", item.weightLb)) lb")
                                        .font(.system(size: 14))
                                        .foregroundColor(.gray)
                                }
                                
                                Spacer()
                                
                                HStack(spacing: 4) {
                                    if abs(diff) < 0.01 {
                                        Text("+0.0 kg")
                                            .foregroundStyle(Color.black)
                                    } else {
                                        Image(systemName: diff > 0 ? "arrow.up" : "arrow.down")
                                            .foregroundStyle(diff > 0 ? Color.red : Color.green)

                                        Text(String(format: "%+.1f kg", diff))
                                            .foregroundStyle(diff > 0 ? Color.red : Color.green)
                                    }
                                }
                                .font(.system(size: 15))
                                .bold()

                                
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                                    .font(.system(size: 15))
                                    .foregroundStyle(Color.black)
                            }
                            .background(Color.white)
                        }
                        Divider().background(Color.black)
                    }
                }
            }
            .padding()
        }
        .overlay(
            Group {
                if showDialog, let item = selectedItem {
                    DailogWeight(
                        isPresented: $showDialog,
                        date: formatDate(from: item.time),
                        initialWeight: item.weightKg
                    ) { newWeight in
                        let id = item.id
                        if let index = historyList.firstIndex(where: { $0.id == id }) {
                            let oldWeight = historyList[index].weightKg
                            if abs(oldWeight - newWeight) < 0.01 {
                                print("⚠️ Không có thay đổi, bỏ qua cập nhật.")
                                return
                            }
                            
                            guard historyList.indices.contains(index) else {
                                print("🚨 Index không hợp lệ: \(index)")
                                return
                            }
                            
                            historyList[index].weightKg = newWeight
                            historyList[index].weightLb = newWeight * 2.20462
                            weightDifferences[id] = newWeight
                            
                            DatabaseData.shared.updateWeight(
                                id: id,
                                newWeightKg: newWeight,
                                newWeightLb: newWeight * 2.20462
                            )
                            print("✅ Cập nhật thành công id: \(id)")
                        } else {
                            print("🚨 Không tìm thấy item có id: \(id)")
                        }
                        
                        // Reset selectedItem tránh update lại
                        selectedItem = nil
                    }
                }
                
            }
        )
        .onAppear {
            DatabaseData.shared.deleteEntriesOlderThan7Days()
            self.historyList = DatabaseData.shared.getRecent7Days()
        }
    }
    
    func formatDate(from input: String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "dd/MM/yyyy"
        
        if let date = inputFormatter.date(from: input) {
            return outputFormatter.string(from: date)
        } else {
            return input
        }
    }
}

#Preview {
    HistoryWeight()
}
