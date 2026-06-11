//
//  SearchLocationsUseCase.swift
//  SkyGlass
//
//  Created by Mona Zarea on 10/06/2026.
//


import Foundation
protocol SearchLocationsUseCaseProtocol {
    func execute(query: String) async throws -> [SearchLocationEntity]
}   
class SearchLocationsUseCase : SearchLocationsUseCaseProtocol {
    private let repository: LocationRepositoryProtocol
    
    init(repository: LocationRepositoryProtocol ) {
        self.repository = repository
    }
    
    func execute(query: String) async throws -> [SearchLocationEntity] {
        
        return try await repository.searchLocations(query: query)
    }
}
