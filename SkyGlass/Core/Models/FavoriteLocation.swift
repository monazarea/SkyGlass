//
//  FavoriteLocation.swift
//  SkyGlass
//
//  Created by Mona Zarea on 11/06/2026.
//

import Foundation
import SwiftData

@Model
final class FavoriteLocation {
    @Attribute(.unique) var id: Int
    var cityName: String
    var region: String
    var country: String
    var latitude: Double
    var longitude: Double
    var savedAt: Date
    
    init(id: Int, cityName: String, region: String, country: String, latitude: Double, longitude: Double, savedAt: Date = Date()) {
        self.id = id
        self.cityName = cityName
        self.region = region
        self.country = country
        self.latitude = latitude
        self.longitude = longitude
        self.savedAt = savedAt
    }
}
