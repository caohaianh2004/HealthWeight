//
//  MeasureKg.swift
//  Health_Weight
//
//  Created by Boss on 11/06/2025.
//

import SwiftUI

struct MeasureKg: View {
    @EnvironmentObject var route: Router
    @Binding var selectionKg: Double
    let values: [Double] = stride(from: 0.0, through: 280.0, by: 0.1).map { $0.rounded(toPlaces: 1) }
    let tickSpacing: CGFloat = 8
    
    var body: some View {
        VStack {
            Text(String(format: "Current Weight (%.1f kg)", selectionKg))
                .foregroundStyle(Color.green)
                .bold()
            
            ZStack {
                Rectangle()
                    .fill(Color.red)
                    .frame(width: 4, height: 30)
                    .padding(.top, -40)
                
                HStack(spacing: 40) {
                    
                    CustomScrollHeightkg(
                        values: values,
                        tickSpacing: tickSpacing,
                        selectedValue: $selectionKg
                    )
                    .frame(height: 80)
                    .background(Color.green.opacity(0.1))
                    
                }
                .padding()
            }
            
            Text(localizedkey: "abc_text")
                .font(.system(size: 13))
                .padding(5)
            Measuringmachine(currentBMI: selectionKg)
        }
    }
}

struct CustomScrollHeightkg: UIViewRepresentable {
    let values: [Double]
    let tickSpacing: CGFloat
    @Binding var selectedValue: Double

    func makeUIView(context: Context) -> UIScrollView {
        let scrollView = UIScrollView()
        scrollView.delegate = context.coordinator
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.decelerationRate = .fast
        scrollView.bounces = true
        scrollView.alwaysBounceHorizontal = true

        let contentView = UIView()
        var xOffset: CGFloat = 0
        let totalWidth = tickSpacing * CGFloat(values.count)
        let screenWidth = UIScreen.main.bounds.width
        
        for value in values {
            let isMajor = value.truncatingRemainder(dividingBy: 1.0) == 0
            let showLabel = isMajor

            let marker = UIView()
            marker.frame = CGRect(x: xOffset, y: 0, width: tickSpacing, height: 50)

            let line = UIView()
            line.backgroundColor = isMajor ? .label : .systemGray
            line.frame = CGRect(
                x: tickSpacing / 2 - 1,
                y: 0,
                width: 2,
                height: isMajor ? 25 : 12 // 👉 bỏ chiều cao riêng cho .5
            )

            if showLabel {
                let label = UILabel()
                if value.truncatingRemainder(dividingBy: 1.0) == 0 {
                    label.text = String(Int(value)) // Số nguyên → 60
                } else {
                    label.text = String(format: "%.1f", value) // Số lẻ → 60.5
                }

                label.font = .systemFont(ofSize: 11)
                label.textColor = .secondaryLabel
                label.sizeToFit()
                label.frame.origin = CGPoint(
                    x: tickSpacing / 2 - label.frame.width / 2,
                    y: 30
                )
                marker.addSubview(label)
            }


            marker.addSubview(line)
            contentView.addSubview(marker)
            xOffset += tickSpacing
        }


        scrollView.addSubview(contentView)
        contentView.frame = CGRect(x: 0, y: 0, width: totalWidth, height: 50)
        scrollView.contentSize = contentView.frame.size

        scrollView.contentInset = UIEdgeInsets(
            top: 0,
            left: screenWidth / 2 - tickSpacing / 2,
            bottom: 0,
            right: screenWidth / 2 - tickSpacing / 2
        )

        if let initialIndex = values.firstIndex(of: selectedValue) {
            let initialOffset = CGFloat(initialIndex) * tickSpacing - (screenWidth / 2 - tickSpacing / 2)
            scrollView.contentOffset = CGPoint(x: initialOffset, y: 0)
        }

        return scrollView
    }

    func updateUIView(_ uiView: UIScrollView, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    class Coordinator: NSObject, UIScrollViewDelegate {
        var parent: CustomScrollHeightkg

        init(parent: CustomScrollHeightkg) {
            self.parent = parent
        }

        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            let centerX = scrollView.bounds.width / 2
            let position = scrollView.contentOffset.x + centerX
            let index = Int(round(position / parent.tickSpacing))
            if index >= 0 && index < parent.values.count {
                let newValue = parent.values[index]
                if newValue != parent.selectedValue {
                    parent.selectedValue = newValue
                }
            }
        }

        func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
            let centerX = scrollView.bounds.width / 2
            let position = targetContentOffset.pointee.x + centerX
            let index = Int(round(position / parent.tickSpacing))
            let newOffset = CGFloat(index) * parent.tickSpacing - centerX
            targetContentOffset.pointee.x = newOffset
        }
    }
}

struct Measuringmachine: View {
    var currentBMI: Double
    
    let bmiZones: [(range: ClosedRange<Double>, label: String, color: Color)] = [
        (0...25.5, "Severe Thinness", .blue),
        (25.6...35.0, "Moderate Thinness", .blue.opacity(0.5)),
        (35.1...49.0, "Mild Thinness", .blue.opacity(0.3)),
        (49.1...109.7, "Normal", .green),
        (109.8...158.0, "Overweight", .yellow),
        (158.1...205.0, "Overweight II", .orange),
        (205.1...253.0, "Obesity", .red.opacity(0.7)),
        (253.1...280, "Obesity II", .red)
     ]
    var bmiCategoryLabel: String {
        bmiZones.first(where: { $0.range.contains(currentBMI) })?.label ?? "Unknown"
    }

    var bmiCategoryColor: Color {
        bmiZones.first(where: { $0.range.contains(currentBMI) })?.color ?? .gray
    }

    var body: some View {
        let minBMI: Double = 0
        let maxBMI: Double = 280
        let minAngle: Double = -92
        let maxAngle: Double = 92

        // Tính góc quay theo tỉ lệ cân nặng
        let clampedWeight = min(max(currentBMI, minBMI), maxBMI)
        let rotationAngle = (clampedWeight - minBMI) / (maxBMI - minBMI) * (maxAngle - minAngle) + minAngle
        
        return VStack {
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
                    .rotationEffect(.degrees(rotationAngle), anchor: .bottom) // quay quanh đáy kim
                    .animation(.easeInOut(duration: 0.2), value: rotationAngle)
            }

            Text("BMI = \(String(format: "%.1f", currentBMI)) kg/m2")
                            .font(.headline)
            
                        Text("(\(bmiCategoryLabel))")
                            .font(.system(size: 15))
                            .bold()
                            .foregroundColor(bmiCategoryColor)
        }
    }
}


extension Double {
    func roundede(toPlaces places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

//#Preview {
//    MeasureKg()
//}
