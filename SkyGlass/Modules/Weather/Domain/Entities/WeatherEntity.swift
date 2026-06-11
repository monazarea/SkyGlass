//
//  WeatherEntity.swift
//  SkyGlass
//
//  Created by Mona Zarea on 09/06/2026.
//

import Foundation
struct WeatherEntity {
    let id: Int
    let cityName: String
    let region: String
    let country: String
    let isDay: Int
    let coordinate: Coordinate
    let tempC: Double
    let feelsLikeC: Double
    let humidity: Int
    let pressureMb: Double
    let windKph: Double
    let conditionText: String
    let conditionIconUrl: String
    let conditionCode: Int
    let forecast: [DayEntity]
}

struct DayEntity :Hashable{
    let date: String
    let maxTempC: Double
    let minTempC: Double
    let conditionText: String
    let conditionIconUrl: String
    let conditionCode: Int
    let hours: [HourEntity]
}

struct HourEntity :Hashable {
    let time: String
    let tempC: Double
    let feelsLikeC: Double
    let humidity: Int
    let windKph: Double
    let pressureMb: Double    
    let conditionText: String
    let conditionIconUrl: String
    let conditionCode: Int
}
