//
//  WeatherMapper.swift
//  SkyGlass
//
//  Created by Mona Zarea on 09/06/2026.
//

import Foundation

struct WeatherMapper {
    
    static func map(response: WeatherResponse) -> WeatherEntity {
        return WeatherEntity(
            id: response.location.name.hashValue,
            cityName: response.location.name,
            
            region: response.location.region ?? "",
            country: response.location.country ?? "Unknown",
            
            isDay: response.current.isDay,
            coordinate: Coordinate(lat: response.location.lat, lon: response.location.lon),
            tempC: response.current.tempC,
            
            feelsLikeC: response.current.feelslikeC ?? response.current.tempC,
            
            humidity: response.current.humidity ?? 0,
            pressureMb: response.current.pressureMb ?? 0.0,
            windKph: response.current.windKph ?? 0.0,
            
            conditionText: response.current.condition.text,
            conditionIconUrl: response.current.condition.icon.withHttpPrefix(),
            conditionCode: response.current.condition.code,
            
            forecast: response.forecast.forecastday.map { mapDay($0) }
        )
    }
    
    private static func mapDay(_ forecastDay: ForecastDay) -> DayEntity {
        return DayEntity(
            date: forecastDay.date,
            maxTempC: forecastDay.day.maxtempC,
            minTempC: forecastDay.day.mintempC,
            conditionText: forecastDay.day.condition.text,
            conditionIconUrl: forecastDay.day.condition.icon.withHttpPrefix(),
            conditionCode: forecastDay.day.condition.code,
            hours: forecastDay.hour.map { mapHour($0) }
        )
    }
    
    private static func mapHour(_ hourlyForecast: HourlyForecast) -> HourEntity {
        return HourEntity(
            time: hourlyForecast.time,
            tempC: hourlyForecast.tempC,
            feelsLikeC: hourlyForecast.feelslikeC,
            humidity: hourlyForecast.humidity,
            windKph: hourlyForecast.windKph,
            pressureMb: hourlyForecast.pressureMb,       
            conditionText: hourlyForecast.condition.text,
            conditionIconUrl: hourlyForecast.condition.icon.withHttpPrefix(),
            conditionCode: hourlyForecast.condition.code
        )
    }
}
