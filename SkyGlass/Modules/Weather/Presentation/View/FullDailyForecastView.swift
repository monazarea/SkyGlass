//
//  FullDailyForecastView.swift
//  SkyGlass
//
//  Created by Mona Zarea on 11/06/2026.
//

import SwiftUI

struct FullDailyForecastView: View {
    let days: [DayEntity]
    let theme: AppTheme
    
    var body: some View {
        ZStack {
            Image(theme.backgroundImageName)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            theme.backgroundOverlay
                .ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 16) {
                    
                    HStack {
                        Image(systemName: "calendar")
                        Text("10-DAY FORECAST")
                            .font(.caption)
                            .fontWeight(.bold)
                            .tracking(1.5)
                    }
                    .foregroundColor(theme.primaryTextColor)
                    .padding(.bottom, 4)
                    
                    VStack(spacing: 16) {
                        ForEach(days, id: \.date) { day in
                            DailyRowView(day: day, theme: theme)
                            
                            if day.date != days.last?.date {
                                Divider()
                                    .background(theme.primaryTextColor.opacity(0.2))
                            }
                        }
                    }
                }
                .padding(20)
                .glassStyle(cornerRadius: 24, theme: theme, opacity: 0.6)
                .padding()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        
        
        .toolbarBackground(.hidden, for: .navigationBar)
        
        .toolbarColorScheme(theme.primaryTextColor == .white ? .dark : .light, for: .navigationBar)
    }
}

#Preview {
    NavigationView {
        FullDailyForecastView(days: DayEntity.mockArray, theme: .clearNight)
    }
}
