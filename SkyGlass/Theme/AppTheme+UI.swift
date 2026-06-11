//
//  AppTheme+UI.swift
//  SkyGlass
//
//  Created by Mona Zarea on 10/06/2026.
//

import Foundation
import SwiftUI

extension AppTheme {
    
    var backgroundImageName: String {
        switch self {
        case .sunny: return "sunny_bg"
        case .clearNight: return "clear_night_bg"
        case .cloudyDay: return "cloudy_day_bg"
        case .cloudyNight: return "cloudy_night_bg"
        case .rainyDay: return "rainy_day_bg"
        case .rainyNight: return "rainy_night_bg"
        case .snowyDay: return "snowy_day_bg"
        case .snowyNight: return "snowy_night_bg"
        }
    }
    
    var themeColor: Color {
        switch self {
        case .sunny: return Color.orange
        case .clearNight: return Color.indigo
        case .cloudyDay: return Color.gray
        case .cloudyNight: return Color(hex: "374151")
        case .rainyDay: return Color.blue
        case .rainyNight: return Color(hex: "1E3A8A")
        case .snowyDay: return Color.cyan
        case .snowyNight: return Color(hex: "475569")
        }
    }
    
    var primaryTextColor: Color {
            switch self {
            case .sunny, .cloudyDay, .rainyDay, .snowyDay:
                return Color(hex: "2D3740")
                
            case .clearNight, .cloudyNight, .rainyNight, .snowyNight:
                return .white
            }
        }
        
        var backgroundOverlay: Color {
            switch self {
            case .sunny, .cloudyDay, .rainyDay, .snowyDay:
                return Color.white.opacity(0.1)
                
            case .clearNight, .cloudyNight, .rainyNight, .snowyNight:
                return Color.black.opacity(0.25)
            }
        }
}
