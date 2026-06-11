//
//  LocationRepository.swift
//  SkyGlass
//
//  Created by Mona Zarea on 10/06/2026.
//

import Foundation

protocol LocationRepositoryProtocol {
    func searchLocations(query: String) async throws -> [SearchLocationEntity]
}
class LocationRepository: LocationRepositoryProtocol {
    private let weatherService: WeatherServicesProtocol
    
    init(weatherService: WeatherServicesProtocol) {
        self.weatherService = weatherService
    }
    
    func searchLocations(query: String) async throws -> [SearchLocationEntity] {
        let responses = try await weatherService.searchCity(query: query)
        return SearchLocationMapper.map(responses: responses)
    }
}
