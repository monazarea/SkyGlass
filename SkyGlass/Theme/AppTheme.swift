//
//  AppTheme.swift
//  SkyGlass
//
//  Created by Mona Zarea on 09/06/2026.
//

import Foundation

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
