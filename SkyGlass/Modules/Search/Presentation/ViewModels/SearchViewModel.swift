//
//  SearchViewModel.swift
//  SkyGlass
//
//  Created by Mona Zarea on 11/06/2026.
//
//
//  SearchViewModel.swift
//  SkyGlass
//

import Foundation
import Combine

@MainActor
final class SearchViewModel: ObservableObject {

    @Published var searchText: String = ""
    @Published var searchResults: [SearchLocationEntity] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil

    private let searchUseCase: SearchLocationsUseCaseProtocol
    private let locationService: LocationServiceProtocol
    private var cancellables = Set<AnyCancellable>()

    init(searchUseCase: SearchLocationsUseCase, locationService: LocationServiceProtocol) {
            self.searchUseCase = searchUseCase
            self.locationService = locationService
            setupSearchDebounce()
    }
    private func setupSearchDebounce() {
        $searchText
            .removeDuplicates()
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .sink { [weak self] query in
                guard let self else { return }
                if query.count >= 3 {
                    self.performSearch(query: query)
                } else {
                    self.searchResults = []
                    self.errorMessage = nil
                }
            }
            .store(in: &cancellables)
    }

    private func performSearch(query: String) {
        isLoading = true
        errorMessage = nil

        Task {
            do {
                let results = try await searchUseCase.execute(query: query)
                self.searchResults = results
                if results.isEmpty {
                    self.errorMessage = "No locations found for '\(query)'."
                }
            } catch let error as ApiError {
                self.errorMessage = error.localizedDescription
                self.searchResults = []
            } catch {
                self.errorMessage = ApiError.unknown.localizedDescription
                self.searchResults = []
            }
            self.isLoading = false
        }
    }

    func clearSearch() {
        searchText = ""
        searchResults = []
        errorMessage = nil
    }
    func selectLocation(_ location: SearchLocationEntity) {
            locationService.updateCustomLocation(location.coordinate)
        }
}
