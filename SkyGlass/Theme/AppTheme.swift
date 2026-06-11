//
//  AppTheme.swift
//  SkyGlass
//
//  Created by Mona Zarea on 09/06/2026.
//

import Foundation
import SwiftUI
enum AppTheme {
    case sunny
    case clearNight
    case cloudyDay
    case cloudyNight
    case rainyDay
    case rainyNight
    case snowyDay
    case snowyNight
    
    static func getTheme(conditionCode: Int, isDay: Int) -> AppTheme {
        let isDaytime = (isDay == 1)
        
        switch conditionCode {
        case 1000:
            return isDaytime ? .sunny : .clearNight
            
        case 1003, 1006, 1009: 
            return isDaytime ? .cloudyDay : .cloudyNight
            
        case 1063...1201, 1240...1246, 1273...1276:
            return isDaytime ? .rainyDay : .rainyNight
            
        case 1066...1069, 1210...1237, 1255...1260, 1279...1282:
            return isDaytime ? .snowyDay : .snowyNight
            
        default:
            return isDaytime ? .sunny : .clearNight
        }
    }
}

//
//extension AppTheme {
//    var backgroundGradient: LinearGradient {
//        switch self {
//        case .sunny:
//            return LinearGradient(colors: [Color.blue.opacity(0.8), Color.blue.opacity(0.4)], startPoint: .top, endPoint: .bottom)
//        case .clearNight:
//            return LinearGradient(colors: [Color(hex: "0B1D3A"), Color(hex: "1A365D")], startPoint: .top, endPoint: .bottom)
//        case .cloudyDay:
//            return LinearGradient(colors: [Color.gray.opacity(0.8), Color.gray.opacity(0.5)], startPoint: .top, endPoint: .bottom)
//        case .cloudyNight:
//            return LinearGradient(colors: [Color(hex: "1F2937"), Color(hex: "374151")], startPoint: .top, endPoint: .bottom)
//        case .rainyDay:
//            return LinearGradient(colors: [Color.gray, Color.blue.opacity(0.6)], startPoint: .top, endPoint: .bottom)
//        case .rainyNight:
//            return LinearGradient(colors: [Color(hex: "111827"), Color(hex: "1E3A8A")], startPoint: .top, endPoint: .bottom)
//        case .snowyDay:
//            return LinearGradient(colors: [Color.blue.opacity(0.3), Color.white.opacity(0.8)], startPoint: .top, endPoint: .bottom)
//        case .snowyNight:
//            return LinearGradient(colors: [Color(hex: "1E293B"), Color(hex: "475569")], startPoint: .top, endPoint: .bottom)
//        }
//    }
//}
//
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default: (a, r, g, b) = (1, 1, 1, 0)
        }
        self.init(.sRGB, red: Double(r) / 255, green: Double(g) / 255, blue:  Double(b) / 255, opacity: Double(a) / 255)
    }
}
