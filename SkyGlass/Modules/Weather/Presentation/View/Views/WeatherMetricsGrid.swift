//  WeatherMetricsGrid.swift
//  SkyGlass

import SwiftUI

struct WeatherMetricsGrid: View {
    let weather: WeatherEntity
    let hourlyForecast: [HourEntity]
    let theme: AppTheme
    
    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 16) {
            
            MetricCardView(
                iconName: "humidity",
                title: "HUMIDITY",
                value: "\(weather.humidity)%",
                subtext: humiditySubtext(weather.humidity),
                theme: theme,
                chartData: hourlyForecast.enumerated().map {
                    ChartDataPoint(index: $0.offset, value: Double($0.element.humidity))
                },
                chartColor: .cyan
            )
            
            MetricCardView(
                iconName: "wind",
                title: "WIND",
                value: "\(Int(weather.windKph)) km/h",
                subtext: "Wind speed right now.",
                theme: theme,
                chartData: hourlyForecast.enumerated().map {
                    ChartDataPoint(index: $0.offset, value: $0.element.windKph)
                },
                chartColor: .purple
            )
            
            MetricCardView(
                iconName: "thermometer",
                title: "FEELS LIKE",
                value: "\(Int(weather.feelsLikeC))°",
                subtext: feelsLikeSubtext(actual: weather.tempC, feelsLike: weather.feelsLikeC),
                theme: theme,
                chartData: hourlyForecast.enumerated().map {
                    ChartDataPoint(index: $0.offset, value: $0.element.feelsLikeC)
                },
                chartColor: .orange
            )
            
            MetricCardView(
                iconName: "gauge.medium",
                title: "PRESSURE",
                value: "\(Int(weather.pressureMb)) hPa",
                subtext: "Atmospheric pressure.",
                theme: theme,
                chartData: hourlyForecast.enumerated().map {
                    ChartDataPoint(index: $0.offset, value: $0.element.pressureMb)
                },
                chartColor: .green
            )
        }
    }
    
    private func humiditySubtext(_ humidity: Int) -> String {
           if humidity > 70 { return "High humidity levels." }
           if humidity < 30 { return "Dry conditions." }
           return "Comfortable levels."
       }
       
       private func feelsLikeSubtext(actual: Double, feelsLike: Double) -> String {
           if feelsLike > actual { return "Humidity is making it feel warmer." }
           if feelsLike < actual { return "Wind is making it feel cooler." }
           return "Similar to the actual temperature."
       }}
