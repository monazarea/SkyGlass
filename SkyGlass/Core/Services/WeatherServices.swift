//
//  WeatherServices.swift
//  SkyGlass
//
//  Created by Mona Zarea on 09/06/2026.
//

import Foundation

protocol WeatherServicesProtocol {
    func fetchForecast(for coordinate : Coordinate) async throws -> WeatherResponse
    func searchCity(query: String) async throws -> [SearchLocationResponse]

}

final class WeatherServices: WeatherServicesProtocol {
    
    
    private let apiClient : ApiClientProtocol
    
    init(apiClient: ApiClientProtocol) {
        self.apiClient = apiClient
    }
    
    func fetchForecast(for coordinate: Coordinate) async throws ->
    WeatherResponse{
        return try await apiClient.request(endpoint: .forecast(location: coordinate.queryString, days: 10), responseType: WeatherResponse.self)
    }
    
    func searchCity(query: String) async throws -> [SearchLocationResponse] {
            return try await apiClient.request(endpoint: .search(query: query), responseType: [SearchLocationResponse].self)
        }
    
}


