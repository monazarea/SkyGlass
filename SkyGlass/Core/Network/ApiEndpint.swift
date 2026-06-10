//
//  ApiEndpint.swift
//  SkyGlass
//
//  Created by Mona Zarea on 09/06/2026.
//

import Foundation
import Alamofire

enum ApiEndpoint {
    case forecast(location: String, days: Int)
    case search(query: String)
    
    var path: String {
        switch self {
        case .forecast:
            return "/" + ApiConstants.EndPoint.forcast
        case .search:
            return "/" + ApiConstants.EndPoint.search
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var parameters: Parameters? {
        switch self {
        case .forecast(let location, let days):
            return [
                ApiConstants.Parameters.query: location,
                ApiConstants.Parameters.days: days
            ]
        case .search(let query):
            return [
                ApiConstants.Parameters.query: query
            ]
        }
    }
    
    var url: URL? {
        let fullURLString = ApiConstants.baseURL + path
        return URL(string: fullURLString)
    }
}
