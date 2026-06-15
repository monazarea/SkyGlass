//
//  FullDailyForecastView.swift
//  SkyGlass
//
//  Created by Mona Zarea on 11/06/2026.
//

import SwiftUI

struct FullDailyForecastView: View {
    let days: [DayEntity]
    @EnvironmentObject private var themeManager: ThemeManager

    var body: some View {
        ZStack {
            Image(themeManager.currentTheme.backgroundImageName)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            themeManager.currentTheme.backgroundOverlay
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
                    .foregroundColor(themeManager.currentTheme.primaryTextColor)
                    .padding(.bottom, 4)
                    
                    VStack(spacing: 16) {
                        ForEach(days, id: \.date) { day in
                            DailyRowView(day: day)
                            
                            if day.date != days.last?.date {
                                Divider()
                                    .background(themeManager.currentTheme.primaryTextColor.opacity(0.2))
                            }
                        }
                    }
                }
                .padding(20)
                .glassStyle(cornerRadius: 24, opacity: 0.6)
                .padding()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        
        
        .toolbarBackground(.hidden, for: .navigationBar)
        
        .toolbarColorScheme(themeManager.currentTheme.primaryTextColor == .white ? .dark : .light, for: .navigationBar)
    }
}
#if DEBUG
#Preview {
    NavigationView {
        FullDailyForecastView(days: DayEntity.mockArray)
    }
}
#endif
