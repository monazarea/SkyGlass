import Foundation
import Combine

protocol FavoritesRepositoryProtocol {
    var favoritesPublisher: AnyPublisher<[FavoriteLocation], Never> { get }
    
    func refreshFavorites() throws
    func addFavorite(_ location: FavoriteLocation) throws
    func removeFavorite(id: Int) throws
    func isFavorite(id: Int) throws -> Bool
}

final class FavoritesRepository: FavoritesRepositoryProtocol {
    private let localService: FavoritesLocalServiceProtocol
    
    private let favoritesSubject = CurrentValueSubject<[FavoriteLocation], Never>([])
    
    var favoritesPublisher: AnyPublisher<[FavoriteLocation], Never> {
        return favoritesSubject.eraseToAnyPublisher()
    }
    
    init(localService: FavoritesLocalServiceProtocol) {
        self.localService = localService
        try? refreshFavorites()
    }
    
    func refreshFavorites() throws {
        let favs = try localService.fetchFavorites()
        favoritesSubject.send(favs)
    }
    
    func addFavorite(_ location: FavoriteLocation) throws {
        try localService.insertFavorite(location)
        try refreshFavorites()
    }
    
    func removeFavorite(id: Int) throws {
        try localService.deleteFavorite(id: id)
        try refreshFavorites()
    }
    
    func isFavorite(id: Int) throws -> Bool {
        return try localService.isFavorite(id: id)
    }
}
