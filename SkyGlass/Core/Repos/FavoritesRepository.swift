//
//  FavoritesRepository.swift
//  SkyGlass
//
//  Created by Mona Zarea on 11/06/2026.
//



import Foundation
import SwiftData
protocol FavoritesRepositoryProtocol {
    func fetchFavorites() throws -> [FavoriteLocation]
    func addFavorite(_ location: FavoriteLocation) throws
    func removeFavorite(_ location: FavoriteLocation) throws
    func isFavorite(id: Int) throws -> Bool
    func removeFavorite(id: Int) throws
}

@MainActor
final class FavoritesRepository: FavoritesRepositoryProtocol {
    
    private let context: ModelContext
    
    init(context: ModelContext) {
        self.context = context
    }
    
    func fetchFavorites() throws -> [FavoriteLocation] {
        let descriptor = FetchDescriptor<FavoriteLocation>(sortBy: [SortDescriptor(\.savedAt, order: .reverse)])
        return try context.fetch(descriptor)
    }
    
    func addFavorite(_ location: FavoriteLocation) throws {
        context.insert(location)
        try context.save()
    }
    
    func removeFavorite(_ location: FavoriteLocation) throws {
        context.delete(location)
        try context.save()
    }
    func removeFavorite(id: Int) throws {
            let descriptor = FetchDescriptor<FavoriteLocation>(
                predicate: #Predicate { $0.id == id }
            )
            if let itemToDelete = try context.fetch(descriptor).first {
                context.delete(itemToDelete)
                try context.save()
            }
        }
    
    func isFavorite(id: Int) throws -> Bool {
        let descriptor = FetchDescriptor<FavoriteLocation>(
            predicate: #Predicate { $0.id == id }
        )
        let count = try context.fetchCount(descriptor)
        return count > 0
    }
}
