//
//  AppContainer.swift
//  SkyGlass
//
//  Created by Mona Zarea on 09/06/2026.
//

import Foundation
final class AppContainer {
    
        
    init() {}
    
    private lazy var weatherService: WeatherServicesProtocol = {
            return WeatherServices(apiClient: ApiClient.shared)
    }()
        
    private lazy var locationService: LocationServiceProtocol = {
            return LocationService()
    }()
    
    private lazy var weatherRepository: WeatherRepositoryProtocol = {
            return WeatherRepository(networkService: weatherService)
    }()
        
    func makeWeatherUseCase() -> WeatherUseCaseProtocol {
        return WeatherUseCase(repository: weatherRepository)
    }
    @MainActor func makeWeatherViewModel() -> WeatherViewModel {
        return WeatherViewModel(weatherUseCase: makeWeatherUseCase(),locationService: locationService)
    }
    
}

