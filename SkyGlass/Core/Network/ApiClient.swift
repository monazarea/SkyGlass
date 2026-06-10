//
//  ApiClient.swift
//  SkyGlass
//
//  Created by Mona Zarea on 09/06/2026.
//

import Foundation
import Alamofire
protocol ApiClientProtocol {
    func request<T: Decodable>(endpoint: ApiEndpoint, responseType: T.Type) async throws -> T
}

final class ApiClient: ApiClientProtocol {
    
    static let shared = ApiClient()
    
    private let session: Session
    
    private init() {
        self.session = Session(interceptor: ApiKeyInterceptor())
    }
    
    func request<T: Decodable>(endpoint: ApiEndpoint, responseType: T.Type) async throws -> T {
        
        guard let url = endpoint.url else {
            throw ApiError.invalidURL
        }
        
        let request = session.request(url,
                                      method: endpoint.method,
                                      parameters: endpoint.parameters,
                                      encoding: URLEncoding.default)
        
        let response = await request.serializingDecodable(T.self).response
        
        if let error = response.error {
            if let statusCode = response.response?.statusCode, !(200...299).contains(statusCode) {
                throw ApiError.serverError(statusCode: statusCode)
            }
            if error.isResponseSerializationError {
                throw ApiError.decodingError(error)
            }
            throw ApiError.networkError(error)
        }
        
        guard let value = response.value else {
            throw ApiError.unknown
        }
        
        return value
    }
}
