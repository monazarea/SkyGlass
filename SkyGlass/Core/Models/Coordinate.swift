//
//  Coordinate.swift
//  SkyGlass
//
//  Created by Mona Zarea on 09/06/2026.
//

import Foundation
struct Coordinate: Hashable ,Equatable{
    let lat: Double
    let lon: Double

    var queryString: String {
        "\(lat),\(lon)"
    }
}
