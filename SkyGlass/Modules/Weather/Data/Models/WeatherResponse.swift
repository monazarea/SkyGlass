//
//  WeatherResponse.swift
//  SkyGlass
//
//  Created by Mona Zarea on 09/06/2026.
//

import Foundation
struct WeatherResponse: Decodable {
    let location: Location
    let current: CurrentWeather
    let forecast: Forecast
}

struct Location: Decodable {
    let name: String
    let region: String
    let country: String
    let lat: Double
    let lon: Double
    let localtime: String
}

struct CurrentWeather: Decodable {
    let tempC: Double
    let isDay: Int
    let condition: WeatherCondition
    let windKph: Double
    let windDirection: String
    let humidity: Int
    let feelslikeC: Double
    let visKm: Double
    let pressureMb: Double
    let cloud: Int
    
    enum CodingKeys: String, CodingKey {
        case tempC = "temp_c"
        case isDay = "is_day"
        case condition
        case windKph = "wind_kph"
        case windDirection = "wind_dir"
        case humidity
        case feelslikeC = "feelslike_c"
        case visKm = "vis_km"
        case pressureMb = "pressure_mb"
        case cloud
    }
}

struct WeatherCondition: Decodable {
    let text: String
    let icon: String
    let code: Int
}

struct Forecast: Decodable {
    let forecastday: [ForecastDay]
}

struct ForecastDay: Decodable {
    let date: String
    let day: DailyForecast
    let hour: [HourlyForecast]
}

struct DailyForecast: Decodable {
    let maxtempC: Double
    let mintempC: Double
    let avgtempC: Double
    let dailyChanceOfRain: Int
    let condition: WeatherCondition
    
    enum CodingKeys: String, CodingKey {
        case maxtempC = "maxtemp_c"
        case mintempC = "mintemp_c"
        case avgtempC = "avgtemp_c"
        case dailyChanceOfRain = "daily_chance_of_rain"
        case condition
    }
}

struct HourlyForecast: Decodable {
    let time: String
    let tempC: Double
    let condition: WeatherCondition
    let chanceOfRain: Int
    
    enum CodingKeys: String, CodingKey {
        case time
        case tempC = "temp_c"
        case condition
        case chanceOfRain = "chance_of_rain"
    }
}
