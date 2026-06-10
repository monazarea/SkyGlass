//
//  ApiKeyInterceptor.swift
//  SkyGlass
//
//  Created by Mona Zarea on 09/06/2026.
//

import Foundation
import Alamofire
final class ApiKeyInterceptor: RequestInterceptor {
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        
        guard let url = urlRequest.url, var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            return completion(.success(urlRequest))
        }
        
        var queryItems = components.queryItems ?? []
        queryItems.append(URLQueryItem(name: ApiConstants.Parameters.key, value: ApiConstants.apiKey))
        components.queryItems = queryItems
        
        var newRequest = urlRequest
        newRequest.url = components.url
        completion(.success(newRequest))

    }
}
