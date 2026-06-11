//
//  TemperatureColorHelper.swift
//  SkyGlass
//
//  Created by Mona Zarea on 11/06/2026.
//

import SwiftUI

struct TemperatureColorHelper {
    
    private static func color(for temp: Double) -> Color {
        switch temp {
        case ..<0:
            return Color.purple
        case 0..<10:
            return Color.blue
        case 10..<18:
            return Color.teal
        case 18..<24:
            return Color.green
        case 24..<28:
            return Color.yellow
        case 28..<35:
            return Color.orange
        default:
            return Color.red
        }
    }
    
    static func gradient(minTemp: Double, maxTemp: Double) -> LinearGradient {
        let startColor = color(for: minTemp)
        let endColor = color(for: maxTemp)
        
        if startColor == endColor {
            return LinearGradient(
                colors: [startColor.opacity(0.7), endColor],
                startPoint: .leading,
                endPoint: .trailing
            )
        }
        
        return LinearGradient(
            colors: [startColor, endColor],
            startPoint: .leading,
            endPoint: .trailing
        )
    }
}
