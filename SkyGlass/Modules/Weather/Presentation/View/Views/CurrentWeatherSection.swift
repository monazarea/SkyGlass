//
//  CurrentWeatherSection.swift
//  SkyGlass
//
//  Created by Mona Zarea on 10/06/2026.
//

import SwiftUI

struct CurrentWeatherSection: View {
    
    let weather : WeatherEntity
    let theme: AppTheme
    
    var body: some View {
        VStack(spacing: 8) {
            HStack {
                Image(systemName: "mappin.and.ellipse")
                Text(weather.country.uppercased())
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .tracking(2)
            }
            .foregroundColor(theme.primaryTextColor.opacity(0.8))
            
            
                Text("\(Int(weather.tempC))°")
                    .font(.system(size: 96, weight: .bold, design: .rounded))
                    .foregroundColor(theme.primaryTextColor)

            }
            
            Text(weather.conditionText)
                .font(.title2)
                .fontWeight(.medium)
                .foregroundColor(theme.primaryTextColor)
            
            HStack(spacing: 12) {
                Text("Feels like \(Int(weather.feelsLikeC))°")
                Divider().frame(height: 15).background(theme.primaryTextColor)
                Text("H:\(Int(30))°  L:\(Int(10))°")
            }
            .font(.subheadline)
            .foregroundColor(theme.primaryTextColor.opacity(0.8))
            .padding(.horizontal, 20)
            .padding(.vertical, 8)
            .overlay(
                Capsule()
                    .stroke(theme.primaryTextColor.opacity(0.3), lineWidth: 1)
            )
        }
    }

#Preview {
    ZStack {
        Color.indigo.ignoresSafeArea()
        
        CurrentWeatherSection(weather: WeatherEntity.mock, theme: .clearNight)
    }
}
