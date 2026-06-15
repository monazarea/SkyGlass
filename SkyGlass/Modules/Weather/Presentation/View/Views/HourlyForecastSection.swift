//
//  HourlyForecastSection.swift
//  SkyGlass
//
//  Created by Mona Zarea on 10/06/2026.
//

import SwiftUI

struct HourlyForecastSection: View {
    let hours: [HourEntity]
    @EnvironmentObject private var themeManager: ThemeManager
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            
            HStack {
                Text("HOURLY FORECAST")
                    .font(.caption)
                    .fontWeight(.bold)
                    .tracking(1.5)
                
                Spacer()
                
                Image(systemName: "clock")
            }
            .foregroundColor(themeManager.currentTheme.primaryTextColor.opacity(0.6))
            .padding(.horizontal, 10)
            .padding(.top, 10)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(hours, id: \.time) { hour in
                        HourlyCardView(hour: hour)
                    }
                }
                .padding(.horizontal, 10)
            }
        }
    }
}

struct HourlyCardView: View {
    let hour: HourEntity
    @EnvironmentObject private var themeManager: ThemeManager

    
    var body: some View {
        VStack(spacing: 12) {
            
            Text(formatTime(hour.time))
                .font(.subheadline)
                .fontWeight(.medium)
            
            AsyncImage(url: URL(string: hour.conditionIconUrl)) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 32, height: 32)
            
            Text("\(Int(hour.tempC))°")
                .font(.title3)
        }
        .foregroundColor(themeManager.currentTheme.primaryTextColor)
        .padding(.vertical, 16)
        .padding(.horizontal, 18)
        
        .glassStyle(cornerRadius: 24,  opacity: 0.6)
    }
    
    private func formatTime(_ timeString: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        if let date = formatter.date(from: timeString) {
            formatter.dateFormat = "h a"
            return formatter.string(from: date)
        }
        return timeString
    }
}
#if DEBUG
#Preview {
    ZStack {
        Color.blue.opacity(0.8).ignoresSafeArea()
        
        HourlyForecastSection(hours: HourEntity.mockArray)
    }
}
#endif
