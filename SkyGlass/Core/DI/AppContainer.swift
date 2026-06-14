//
//  AppContainer.swift
//  SkyGlass
//
//  Created by Mona Zarea on 09/06/2026.
//

import Foundation
import SwiftData

@MainActor
final class AppContainer {
    
    
    let modelContainer: ModelContainer
    
    init() {
        do {
            modelContainer = try ModelContainer(for: FavoriteLocation.self)
        } catch {
            fatalError("Failed to initialize SwiftData ModelContainer: \(error.localizedDescription)")
        }
    }
    
    var modelContext: ModelContext {
        modelContainer.mainContext
    }
    
    private lazy var weatherService: WeatherServicesProtocol = {
        return WeatherServices(apiClient: ApiClient.shared)
    }()
    
    private lazy var locationService: LocationServiceProtocol = {
        return LocationService()
    }()
    
    private lazy var favoriteService: FavoritesLocalServiceProtocol = {
        return FavoritesLocalService(context: modelContext)
    }()

    private lazy var weatherRepository: WeatherRepositoryProtocol = {
            return WeatherRepository(networkService: weatherService)
    }()
    
    private lazy var locationRepository: LocationRepositoryProtocol = {
        return LocationRepository(weatherService: weatherService)
    }()
       
    private lazy var favoritesRepository: FavoritesRepositoryProtocol = {
        return FavoritesRepository(localService: favoriteService)
    }()
      
    func makeSearchUseCase() -> SearchLocationsUseCase {
        return SearchLocationsUseCase(repository: locationRepository)
    }
    func makeWeatherUseCase() -> WeatherUseCaseProtocol {
        return WeatherUseCase(repository: weatherRepository)
    }
    func makeLocationUseCase() -> LocationUseCaseProtocol {
        return LocationUseCase(locationService: locationService)
    }
    
    @MainActor func makeWeatherViewModel() -> WeatherViewModel {
        return WeatherViewModel(weatherUseCase: makeWeatherUseCase(),locationUseCase: makeLocationUseCase(),favoritesRepository: favoritesRepository)
    }
    
    @MainActor func makeSearchViewModel() -> SearchViewModel {
            return SearchViewModel(searchUseCase: makeSearchUseCase(),locationService: locationService)
        }
    @MainActor func makeFavoritesViewModel() -> FavoritesViewModel {
        return FavoritesViewModel(favoritesRepository: favoritesRepository, locationService: locationService)
        }
    
    
    
}

