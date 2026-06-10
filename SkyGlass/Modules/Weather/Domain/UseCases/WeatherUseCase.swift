//
//  WeatherUseCase.swift
//  SkyGlass
//
//  Created by Mona Zarea on 09/06/2026.
//

import Foundation

protocol WeatherUseCaseProtocol {
    func execute(coordinate: Coordinate) async throws -> WeatherEntity
}

struct WeatherUseCase: WeatherUseCaseProtocol {
    
    private let repository: WeatherRepositoryProtocol
    
    init(repository: WeatherRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(coordinate: Coordinate) async throws -> WeatherEntity {
        return try await repository.fetchWeather(for: coordinate)
    }
}
