//
//  Service.swift
//  RickAndMorty
//
//  Created by Thiago Almeida Leite on 03/01/23.
//

import Foundation


/// Primary API service object to get Rick and Morty Data
final class Service {
    
    /// Shared singleton instance
    static let shared = Service()
    
    
    /// Privatized constructor
    private init() {}
    
    enum ServiceError: Error {
          case failedToCreateRequest
          case failedToGetData
      }
    
    /// Send Rick and Morty API call
    /// - Parameters:
    ///   - request: Request instance
    ///   - type: The type if object we expect to get back
    ///   - completion: Callback with data or error
    public func execute<T: Codable>(_ request: Request,
                                    expecting type: T.Type,
                                    completion: @escaping (Result<T, Error>) -> Void) {
        guard let urlRequest = self.request(from: request) else {
            completion(.failure(ServiceError.failedToCreateRequest))
            return
        }
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? ServiceError.failedToGetData))
                return
            }
            
            // Decode response
            do {
                let result = try JSONDecoder().decode(type.self, from: data)
                completion(.success(result))
            }
            catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    // MARK: - Private
    
    private func request(from request: Request) -> URLRequest? {
        guard let url = request.url else { return nil }
        
        var req = URLRequest(url: url)
        req.httpMethod = request.httpMethod
        return req
    }
}

