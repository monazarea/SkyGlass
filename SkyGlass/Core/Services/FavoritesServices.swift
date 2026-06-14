//
//  FavoritesServices.swift
//  SkyGlass
//
//  Created by Mona Zarea on 14/06/2026.
//

import Foundation
import SwiftData

protocol FavoritesLocalServiceProtocol {
    func fetchFavorites() throws -> [FavoriteLocation]
    func insertFavorite(_ location: FavoriteLocation) throws
    func deleteFavorite(id: Int) throws
    func isFavorite(id: Int) throws -> Bool
}

final class FavoritesLocalService: FavoritesLocalServiceProtocol {
    private let context: ModelContext
    
    init(context: ModelContext) {
        self.context = context
    }
    
    func fetchFavorites() throws -> [FavoriteLocation] {
        let descriptor = FetchDescriptor<FavoriteLocation>(sortBy: [SortDescriptor(\.savedAt, order: .reverse)])
        return try context.fetch(descriptor)
    }
    
    func insertFavorite(_ location: FavoriteLocation) throws {
        context.insert(location)
        try context.save()
    }
    
    func deleteFavorite(id: Int) throws {
        let descriptor = FetchDescriptor<FavoriteLocation>(predicate: #Predicate { $0.id == id })
        if let itemToDelete = try context.fetch(descriptor).first {
            context.delete(itemToDelete)
            try context.save()
        }
    }
    
    func isFavorite(id: Int) throws -> Bool {
        let descriptor = FetchDescriptor<FavoriteLocation>(predicate: #Predicate { $0.id == id })
        return try context.fetchCount(descriptor) > 0
    }
}
