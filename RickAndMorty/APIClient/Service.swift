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
    
    /// Send Rick and Morty API call
    /// - Parameters:
    ///   - request: Request instance
    ///   - completion: Callback with data or error
    private func execute<T: Codable>(_ request: Request, expecting type: T.Type,
                                     completion: @escaping (Result<T, Error>) -> Void) {
        
    }
}
