//  Bosta Assessment
//  NetworkManager.swift
//  Created by Ahmed Yasein on 03/12/2024.
//


import Foundation
import Moya
import Combine

class NetworkManager {
    static let shared = NetworkManager()
    private let provider = MoyaProvider<APIService>()
    
    private init (){}
    
    func request<T: Decodable>(_ type: T.Type, target: APIService) -> AnyPublisher<T, Error> {
        print("Requesting URL: \(target.baseURL)\(target.path)")
        print("Parameters: \(target.task)")
        
        return provider
            .requestPublisher(target)
            .tryMap { response in
                print("Response: \(response)")  // Log the entire response
                guard (200..<300).contains(response.statusCode) else {
                    AlertManager.showAlertWithButton(title: "Error", message: "Bad server response")
                    throw URLError(.badServerResponse)
                }
                let decoder = JSONDecoder()
                return try decoder.decode(T.self, from: response.data)
            }
            .mapError { error in
                AlertManager.showAlertWithoutButton(title: "Network Error", message: error.localizedDescription)
                return error as Error
            }
            .eraseToAnyPublisher()
    }

}
