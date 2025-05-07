//
//  NetworkManager.swift
//  AASearch
//
//  Created by Yassine Lamtalaa on 5/6/25.
//

import Foundation

enum ApiError: Error {
    case invalidUrl
    case invalidResponse
    case jsonParsingFailed(String)
}

class NetworkManager {
    
    func doApi<T: Decodable>(endPoint: String, modelName: T.Type, completion: @escaping (Result<T, ApiError>)-> Void) {
        guard let url = URL(string: endPoint) else {
            completion(.failure(ApiError.invalidUrl))
            return
        }

        let urlRequest = URLRequest(url: url)
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let data = data else {
                completion(.failure(ApiError.invalidResponse))
                return
            }
            do {
                let searchResponse = try JSONDecoder().decode(
                    modelName.self, from: data)
                completion(.success(searchResponse))
                print(searchResponse)
            } catch {
                completion(.failure(ApiError.jsonParsingFailed(error.localizedDescription)))
            }
        }.resume()
    }
}
