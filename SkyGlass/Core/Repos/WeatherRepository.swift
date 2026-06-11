//
//  WeatherRepository.swift
//  SkyGlass
//
//  Created by Mona Zarea on 09/06/2026.
//

import Foundation

protocol WeatherRepositoryProtocol {
    func fetchWeather(for coordinate: Coordinate) async throws -> WeatherEntity
}

final class WeatherRepository: WeatherRepositoryProtocol {

    private let networkService: WeatherServicesProtocol
    init(networkService: WeatherServicesProtocol) {
        self.networkService = networkService
    }
    
    func fetchWeather(for coordinate: Coordinate) async throws -> WeatherEntity {
        let response = try await networkService.fetchForecast(for: coordinate)
        let entity = WeatherMapper.map(response: response)
        return entity
    }
    
        
}


