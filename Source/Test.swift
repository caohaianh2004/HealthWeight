import SwiftUI
import Charts

struct BodyFatData: Identifiable {
    let id = UUID()
    let date: Date
    let value: Double
}

let sampleData: [BodyFatData] = [
    BodyFatData(date: Calendar.current.date(byAdding: .day, value: -5, to: Date())!, value: 22.1),
    BodyFatData(date: Calendar.current.date(byAdding: .day, value: -4, to: Date())!, value: 21.8),
    BodyFatData(date: Calendar.current.date(byAdding: .day, value: -3, to: Date())!, value: 21.5),
    BodyFatData(date: Calendar.current.date(byAdding: .day, value: -2, to: Date())!, value: 21.2),
    BodyFatData(date: Calendar.current.date(byAdding: .day, value: -1, to: Date())!, value: 20.9),
    BodyFatData(date: Date(), value: 20.6)
]

struct Test: View {
    var bodyFatData: [BodyFatData]
    
    var body: some View {
        Chart {
            ForEach(bodyFatData) { data in
                LineMark(
                    x: .value("Date", data.date),
                    y: .value("Body Fat %", data.value)
                )
                .interpolationMethod(.catmullRom)
                .foregroundStyle(.green)
                .symbol(Circle())
                .lineStyle(StrokeStyle(lineWidth: 3))
            }
        }
        .chartXAxis {
            AxisMarks(values: .automatic(desiredCount: 6)) { value in
                AxisValueLabel {
                    if let date = value.as(Date.self) {
                        Text(date.formatted(.dateTime.day().month()))
                    }
                }
            }
        }
        .frame(height: 300)
        .padding()
    }
}

#Preview {
    Test(bodyFatData: sampleData)
}
