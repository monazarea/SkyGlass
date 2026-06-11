//
//  MockData.swift
//  SkyGlass
//
//  Created by Mona Zarea on 11/06/2026.
//

import Foundation

// MARK: - Hour Entity Mock
// MARK: - Hour Entity Mock
extension HourEntity {
    static let mockSunny = HourEntity(
        time: "2026-06-11 14:00",
        tempC: 28,
        feelsLikeC: 30,
        humidity: 60,
        windKph: 14,
        pressureMb: 1012,
        conditionText: "Sunny",
        conditionIconUrl: "https://cdn.weatherapi.com/weather/64x64/day/113.png",
        conditionCode: 1000
    )
    
    static let mockCloudy = HourEntity(
        time: "2026-06-11 15:00",
        tempC: 25,
        feelsLikeC: 26,
        humidity: 70,
        windKph: 18,
        pressureMb: 1010,
        conditionText: "Cloudy",
        conditionIconUrl: "https://cdn.weatherapi.com/weather/64x64/day/119.png",
        conditionCode: 1003
    )
    
    static let mockRainy = HourEntity(
        time: "2026-06-11 16:00",
        tempC: 22,
        feelsLikeC: 21,  
        humidity: 85,
        windKph: 25,
        pressureMb: 1008,
        conditionText: "Rain",
        conditionIconUrl: "https://cdn.weatherapi.com/weather/64x64/day/308.png",
        conditionCode: 1195
    )
    
    static let mockArray = [mockSunny, mockCloudy, mockRainy, mockSunny, mockCloudy]
}

// MARK: - Day Entity Mock
extension DayEntity {
    static let mockToday = DayEntity(
        date: "2026-06-11",
        maxTempC: 30,
        minTempC: 18,
        conditionText: "Sunny",
        conditionIconUrl: "https://cdn.weatherapi.com/weather/64x64/day/113.png",
        conditionCode: 1000,
        hours: HourEntity.mockArray
    )
    
    static let mockTomorrow = DayEntity(
        date: "2026-06-12",
        maxTempC: 28,
        minTempC: 16,
        conditionText: "Cloudy",
        conditionIconUrl: "https://cdn.weatherapi.com/weather/64x64/day/119.png",
        conditionCode: 1003,
        hours: HourEntity.mockArray
    )
    
    static let mockArray = [mockToday, mockTomorrow, mockToday]
}

extension WeatherEntity {
    static let mock = WeatherEntity(
        id: 12345,
        cityName: "Alexandria",
        region: "Alexandria Governorate",
        country: "Egypt",
        isDay: 1,
        coordinate: Coordinate(lat: 31.2001, lon: 29.9187),
        tempC: 28.0,
        feelsLikeC: 30.0,
        humidity: 65,
        pressureMb: 1012.0,
        windKph: 15.0,
        conditionText: "Partly cloudy",
        conditionIconUrl: "https://cdn.weatherapi.com/weather/64x64/day/116.png",
        conditionCode: 1003,
        forecast: DayEntity.mockArray 
    )
}
