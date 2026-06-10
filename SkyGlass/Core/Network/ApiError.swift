//
//  ApiError.swift
//  SkyGlass
//
//  Created by Mona Zarea on 09/06/2026.
//

import Foundation

import Foundation

enum ApiError: Error, LocalizedError {
    case invalidURL
    case networkError(Error)
    case decodingError(Error)
    case serverError(statusCode: Int)
    case unknown          
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid request URL"
        case .networkError(let error):
            return error.localizedDescription
        case .decodingError(let error):
            return error.localizedDescription
        case .serverError(let statusCode):
            return "Server error with status code: \(statusCode)"
        case .unknown:
            return "Unknown error occurred"
        }
    }
}
