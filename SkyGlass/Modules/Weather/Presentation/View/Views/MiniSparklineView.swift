
import SwiftUI
import Charts

struct ChartDataPoint: Identifiable {
    let id = UUID()
    let index: Int
    let value: Double
}

struct MiniSparklineView: View {
    let data: [ChartDataPoint]
    let color: Color
    
    var body: some View {
        Chart(data) { point in
            
            AreaMark(
                x: .value("Index", point.index),
                y: .value("Value", point.value)
            )
            .foregroundStyle(
                LinearGradient(
                    colors: [color.opacity(0.4), color.opacity(0.0)],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .interpolationMethod(.catmullRom)
            
            LineMark(
                x: .value("Index", point.index),
                y: .value("Value", point.value)
            )
            .foregroundStyle(color)
            .lineStyle(StrokeStyle(lineWidth: 2))
            .interpolationMethod(.catmullRom)
        }
        .chartXAxis(.hidden)
        .chartYAxis(.hidden)
        .chartYScale(domain: yDomain)
    }
    
    private var yDomain: ClosedRange<Double> {
        let values = data.map(\.value)
        let min = values.min() ?? 0
        let max = values.max() ?? 1
        let range = max - min
        
        let padding = range < 1 ? 5.0 : range * 0.3
        return (min - padding)...(max + padding)
    }
}
