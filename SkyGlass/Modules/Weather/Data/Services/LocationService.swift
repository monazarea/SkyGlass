//
//  LocationService.swift
//  SkyGlass
//
//  Created by Mona Zarea on 10/06/2026.
//
import CoreLocation
import Foundation
protocol LocationServiceProtocol {
    func getCurrentLocation() async throws -> Coordinate
}


final class LocationService: NSObject, LocationServiceProtocol, CLLocationManagerDelegate {
    
    private let locationManager = CLLocationManager()
    
    private var locationContinuation: CheckedContinuation<Coordinate, Error>?
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
    }
    
    func getCurrentLocation() async throws -> Coordinate {
        return try await withCheckedThrowingContinuation { continuation in
            self.locationContinuation = continuation
            
            let status = locationManager.authorizationStatus
            switch status {
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
                
            case .restricted, .denied:
                continuation.resume(throwing: LocationError.unauthorized)
                self.locationContinuation = nil
                
            case .authorizedAlways, .authorizedWhenInUse:
                locationManager.requestLocation()
                
            @unknown default:
                continuation.resume(throwing: LocationError.unableToDetermineLocation)
                self.locationContinuation = nil
            }
        }
    }
    
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        guard let continuation = locationContinuation else { return }
        
        let status = manager.authorizationStatus
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            locationManager.requestLocation()
        } else if status == .denied || status == .restricted {
            continuation.resume(throwing: LocationError.unauthorized)
            locationContinuation = nil
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last, let continuation = locationContinuation else { return }
        
        let coordinate = Coordinate(lat: location.coordinate.latitude, lon: location.coordinate.longitude)
        
        continuation.resume(returning: coordinate)
        locationContinuation = nil
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        if let clError = error as? CLError, clError.code == .locationUnknown { return }
        
        guard let continuation = locationContinuation else { return }
        continuation.resume(throwing: error)
        locationContinuation = nil
    }
}
