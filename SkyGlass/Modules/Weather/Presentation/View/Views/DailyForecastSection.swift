//
//  DailyForecastSection.swift
//  SkyGlass
//
//  Created by Mona Zarea on 11/06/2026.
//

import SwiftUI

struct DailyForecastSection: View {
    let days: [DayEntity]
    let theme: AppTheme
    @EnvironmentObject var appRouter: AppRouter
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            
            HStack {
                Image(systemName: "calendar")
                Text("10-DAY FORECAST")
                    .font(.caption)
                    .fontWeight(.bold)
                    .tracking(1.5)
            }
            .foregroundColor(theme.primaryTextColor.opacity(0.6))
            .padding(.bottom, 4)
            
            VStack(spacing: 16) {
                ForEach(Array(days.prefix(3)), id: \.date) { day in
                    DailyRowView(day: day, theme: theme)
                }
            }
            
            Divider()
                .background(theme.primaryTextColor.opacity(0.2))
                .padding(.vertical, 8)
            
            Button(action: {
                            appRouter.navigate(to: .fullForecast(days: days, theme: theme))
                        }) {
                            Text("VIEW FULL 10-DAY DETAILS")
                                .font(.caption)
                                .fontWeight(.bold)
                                .frame(maxWidth: .infinity)
                        }
                        .foregroundColor(theme.primaryTextColor)
        }
        .padding(20)
        .glassStyle(cornerRadius: 24, theme: theme, opacity: 0.6)
    }
}

struct DailyRowView: View {
    let day: DayEntity
    let theme: AppTheme
    
    var body: some View {
        HStack(spacing: 12) {
            
            Text(day.date.toDayName())
                .font(.subheadline)
                .fontWeight(.medium)
                .frame(width: 50, alignment: .leading)
                .foregroundColor(theme.primaryTextColor)
            
            AsyncImage(url: URL(string: day.conditionIconUrl)) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 30, height: 30)
            
            Text("\(Int(day.minTempC))°")
                .font(.subheadline)
                .foregroundColor(theme.primaryTextColor.opacity(0.6))
                .frame(width: 35, alignment: .trailing)
            
            Capsule()
                .fill(
                    TemperatureColorHelper.gradient(minTemp: day.minTempC, maxTemp: day.maxTempC)
                )
                .frame(height: 5)
                .opacity(0.9)
            
            Text("\(Int(day.maxTempC))°")
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundColor(theme.primaryTextColor)
                .frame(width: 35, alignment: .trailing)
        }
    }
}

#Preview {
    ZStack {
        Color.indigo.ignoresSafeArea()
        DailyForecastSection(days: DayEntity.mockArray, theme: .clearNight)
            .padding()
    }
}
