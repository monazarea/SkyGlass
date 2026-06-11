
import SwiftUI
import Charts

struct MetricCardView: View {
    let iconName: String
    let title: String
    let value: String
    let subtext: String
    let theme: AppTheme
    let chartData: [ChartDataPoint]
    let chartColor: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            HStack(spacing: 6) {
                Image(systemName: iconName)
                Text(title)
                    .font(.caption)
                    .fontWeight(.bold)
                    .tracking(1.0)
            }
            .foregroundColor(theme.primaryTextColor.opacity(0.6))
            .padding(.bottom, 8)
            
            Text(value)
                .font(.system(size: 28, weight: .semibold, design: .rounded))
                .foregroundColor(theme.primaryTextColor)
                .lineLimit(1)
                .minimumScaleFactor(0.7)
            
            Text(subtext)
                .font(.caption)
                .foregroundColor(theme.primaryTextColor.opacity(0.7))
                .lineLimit(2)
                .padding(.top, 4)
            
            Spacer(minLength: 0)
            
            MiniSparklineView(data: chartData, color: chartColor)
                .frame(height: 44)
                .clipped()         
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(height: 180)
        .glassStyle(cornerRadius: 24, theme: theme, opacity: 0.6)
    }
}
