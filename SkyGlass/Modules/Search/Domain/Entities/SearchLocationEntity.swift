//
//  SearchLocationEntity.swift
//  SkyGlass
//
//  Created by Mona Zarea on 10/06/2026.
//

import Foundation

struct SearchLocationEntity: Identifiable, Hashable {
    let id: Int
    let name: String
    let region: String
    let country: String
    let coordinate: Coordinate
    
    var displayName: String {
        if region.isEmpty || region == name {
            return "\(name), \(country)"
        } else {
            return "\(name), \(region), \(country)"
        }
    }
}
