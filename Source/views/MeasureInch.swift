//
//  MeasureInch.swift
//  Health_Weight
//
//  Created by Boss on 05/06/2025.
//

import SwiftUI

struct MeasureInch: View {
    @Binding var selectionValue: Double
    let values: [Double] = stride(from: 0.0, through: 12.0, by: 0.1).map { $0.rounded(toPlaces: 1) }
    let tickSpacing: CGFloat = 12
    
    var body: some View {
        
//                   Text(String(format: "Inch: %.1f", selectionValue))
//                       .font(.title3)
//                       .bold()
//                       .foregroundColor(.blue)
                   
                   ZStack {
                       Rectangle()
                           .fill(Color.red)
                           .frame(width: 4, height: 30)
                           .padding(.top, -40)
                       
                       CustomScrollViews(
                           values: values,
                           tickSpacing: tickSpacing,
                           selectedValue: $selectionValue
                       )
                       .frame(height: 80)
                       .background(Color.green.opacity(0.1))
               }
                   .padding()
    }
}


struct CustomScrollViews: UIViewRepresentable {
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
            let isHalf = value.truncatingRemainder(dividingBy: 1.0) == 0.5
            let showLabel = isMajor || isHalf

            let marker = UIView()
            marker.frame = CGRect(x: xOffset, y: 0, width: tickSpacing, height: 50)

            let line = UIView()
            line.backgroundColor = isMajor ? .label : .systemGray
            line.frame = CGRect(
                x: tickSpacing / 2 - 1,
                y: 0,
                width: 2,
                height: isMajor ? 25 : (isHalf ? 18 : 12)
            )

            if showLabel {
                let label = UILabel()

                // ✅ Hiển thị số tròn không có .0, số lẻ giữ .1f
                if value.truncatingRemainder(dividingBy: 1.0) == 0 {
                    label.text = String(format: "%.0f", value)
                } else {
                    label.text = String(format: "%.1f", value)
                }

                label.font = .systemFont(ofSize: isMajor ? 12 : 10)
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
        contentView.frame = CGRect(
            x: 0,
            y: 0,
            width: totalWidth,
            height: 50
        )
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
        var parent: CustomScrollViews

        init(parent: CustomScrollViews) {
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

extension Double {
    func roundedd(toPlaces places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}


//#Preview {
//    MeasureInch()
//}
