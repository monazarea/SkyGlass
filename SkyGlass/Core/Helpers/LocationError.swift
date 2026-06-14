//
//  LocationError.swift
//  SkyGlass
//
//  Created by Mona Zarea on 10/06/2026.
//

import Foundation

enum LocationError: Error, LocalizedError {
    case unauthorized
    case unableToDetermineLocation
    
    var errorDescription: String? {
        switch self {
        case .unauthorized:
            return "SkyGlass needs location permission to show local weather."
        case .unableToDetermineLocation:
            return "Unable to retrieve your current location. Please check your GPS."
        }
    }
}
