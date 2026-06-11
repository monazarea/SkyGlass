//
//  SearchLocationMapper.swift
//  SkyGlass
//
//  Created by Mona Zarea on 10/06/2026.
//

import Foundation

struct SearchLocationMapper {
    
    static func map(responses: [SearchLocationResponse]) -> [SearchLocationEntity] {
        return responses.map { response in
            SearchLocationEntity(
                id: response.id,
                name: response.name,
                region: response.region,
                country: response.country,
                coordinate: Coordinate(lat: response.lat, lon: response.lon)
            )
        }
    }
}
