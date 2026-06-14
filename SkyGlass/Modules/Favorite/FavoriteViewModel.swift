//
//  FavoritesViewModel.swift
//  SkyGlass
//
import Foundation
import Combine

@MainActor
final class FavoritesViewModel: ObservableObject {
    @Published var favorites: [FavoriteLocation] = []
    @Published var errorMessage: String? = nil
    
    private let favoritesRepository: FavoritesRepositoryProtocol
    private let locationService: LocationServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(favoritesRepository: FavoritesRepositoryProtocol, locationService: LocationServiceProtocol) {
        self.favoritesRepository = favoritesRepository
        self.locationService = locationService
        
        setupFavoritesSubscription()
    }
    
    private func setupFavoritesSubscription() {
        favoritesRepository.favoritesPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] newFavorites in
                self?.favorites = newFavorites
            }
            .store(in: &cancellables)
    }
    
    func loadFavorites() {
        do {
            try favoritesRepository.refreshFavorites()
        } catch {
            errorMessage = "Failed to load favorites: \(error.localizedDescription)"
        }
    }
    
    func removeFavorite(id: Int) {
        do {
            try favoritesRepository.removeFavorite(id: id)
        } catch {
            errorMessage = "Failed to delete: \(error.localizedDescription)"
        }
    }
    
    func selectFavorite(_ location: FavoriteLocation) {
        let coordinate = Coordinate(lat: location.latitude, lon: location.longitude)
        locationService.updateCustomLocation(coordinate)
    }
}
