//
//  LocationUseCase.swift
//  SkyGlass
//
//  Created by Mona Zarea on 13/06/2026.
//

import Foundation
import Combine

protocol LocationUseCaseProtocol {
    var coordinatePublisher: AnyPublisher<Coordinate, Never> { get }
    func requestDeviceLocation()
}

final class LocationUseCase: LocationUseCaseProtocol {
    
    private let locationService: LocationServiceProtocol
    
    init(locationService: LocationServiceProtocol) {
        self.locationService = locationService
    }
    
    var coordinatePublisher: AnyPublisher<Coordinate, Never> {
        return locationService.coordinatePublisher
            .map { optionalCoordinate in
                if let validCoordinate = optionalCoordinate {
                    return validCoordinate
                } else {
                    return Coordinate(lat: 29.9718, lon: 30.9450)
                }
            }
            .eraseToAnyPublisher()
    }
    
    func requestDeviceLocation() {
        locationService.requestDeviceLocation()
    }
}
