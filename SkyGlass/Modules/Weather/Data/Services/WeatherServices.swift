//
//  WeatherServices.swift
//  SkyGlass
//
//  Created by Mona Zarea on 09/06/2026.
//

import Foundation

protocol WeatherServicesProtocol {
    func fetchForecast(for coordinate : Coordinate) async throws -> WeatherResponse
  //  func searchCity(query : String) async throws -> SearchResponse


}

final class WeatherServices: WeatherServicesProtocol {
    
    
    private let apiClient : ApiClientProtocol
    
    init(apiClient: ApiClientProtocol) {
        self.apiClient = apiClient
    }
    
    func fetchForecast(for coordinate: Coordinate) async throws ->
    WeatherResponse{
        return try await apiClient.request(endpoint: .forecast(location: coordinate.queryString, days: 7), responseType: WeatherResponse.self)
    }
}


