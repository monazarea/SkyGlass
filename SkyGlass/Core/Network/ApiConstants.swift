//
//  ApiConstants.swift
//  SkyGlass
//
//  Created by Mona Zarea on 09/06/2026.
//

import Foundation

enum ApiConstants {
    static var baseURL: String {
        
        if let url = Bundle.main.object(forInfoDictionaryKey: "BASE_URL") as? String {
            return url
        }
        if let env = ProcessInfo.processInfo.environment["BASE_URL"] {
            return env
        }
        return "https://api.weatherapi.com/v1"
    }
    
    static var apiKey: String {
        
        if let key = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String {
            return key
        }
        if let env = ProcessInfo.processInfo.environment["API_KEY"] {
            return env
        }
        
        return ""
        

    }
    

    enum EndPoint{
        static let forcast = "forecast.json"
        static let search = "search.json"
    }
    
    enum Parameters {
        static let key = "key"
        static let query = "q"
        static let days = "days"
        static let alerts = "alerts"
    }
}
