//
//  LocationService.swift
//  SkyGlass
//
//  Created by Mona Zarea on 10/06/2026.
//
import CoreLocation
import Foundation
import Combine
protocol LocationServiceProtocol {
    var coordinatePublisher: AnyPublisher<Coordinate, Never> { get }
    func requestDeviceLocation()
    func updateCustomLocation(_ coordinate: Coordinate)
}


final class LocationService: NSObject, LocationServiceProtocol, CLLocationManagerDelegate {
    
    private let coordinateSubject = PassthroughSubject<Coordinate, Never>()
    var coordinatePublisher: AnyPublisher<Coordinate, Never> {
            return coordinateSubject.eraseToAnyPublisher()
        }
    
    
    private let locationManager = CLLocationManager()
    
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
    }
    
    func updateCustomLocation(_ coordinate: Coordinate) {
        coordinateSubject.send(coordinate)
    }
    
    func requestDeviceLocation() {
            let status = locationManager.authorizationStatus
            switch status {
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
            case .restricted, .denied:
                sendFallbackLocation()
            case .authorizedAlways, .authorizedWhenInUse:
                locationManager.requestLocation()
            @unknown default:
                sendFallbackLocation()
            }
        }
    
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
            let status = manager.authorizationStatus
            if status == .authorizedWhenInUse || status == .authorizedAlways {
                manager.requestLocation()
            } else if status == .denied || status == .restricted {
                sendFallbackLocation()
            }
        }
        
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            guard let location = locations.last else { return }
            let coordinate = Coordinate(lat: location.coordinate.latitude, lon: location.coordinate.longitude)
            
            coordinateSubject.send(coordinate)
        }
        
        func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            if let clError = error as? CLError, clError.code == .locationUnknown { return }
            sendFallbackLocation()
        }
        
        
        private func sendFallbackLocation() {
            let fallback = Coordinate(lat: 29.9718, lon: 30.9450)
            coordinateSubject.send(fallback)
        }
}
