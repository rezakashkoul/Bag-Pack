//
//  NetworkManager.swift
//  Bag-Pack
//
//  Created by Reza Kashkoul on 15/1/1401 AP.
//

import Foundation


class NetworkManager {
    
    static let shared = NetworkManager()
    
    func getTravelData(useMockData: Bool, completion: @escaping (Result<[Travel], ApplicationError>)-> Void) {
        let url = ""
        if useMockData {
            completion(.success(MockData.shared.travelMockData))
        } else {
            baseRequest(type: [Travel].self, url: url, completion: completion)
        }
    }
    
    func baseRequest<T: Decodable>(type: T.Type, url: String, completion: @escaping (Result<T, ApplicationError>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(.badURL))
            return
        }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                completion(.failure(.general))
                return
            }
            guard let data = data , let _  = response else {
                completion(.failure(.noData))
                return
            }
            do {
                let decoder = JSONDecoder()
                let newData = try decoder.decode(T.self, from: data)
                completion(.success(newData))
            } catch {
                completion(.failure(.decode))
            }
        }
    }
    
}
