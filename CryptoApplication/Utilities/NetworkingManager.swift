//
//  NetworkingManager.swift
//  CryptoApplication
//
//  Created by MUHAMMAD KASHIF on 06/08/2023.
//

import Foundation
import Combine

class NetworkingManager{
    
    enum NetworkingError: LocalizedError {
        case badURLResponse(url: URL)
        case unKnownError
        
        var errorDescription: String? {
            switch self{
                case .badURLResponse(url: let url): return "[😅] Bad service from URL: \(url)"
                case .unKnownError: return "[⚠️]Unknown Error occured"
            }
        }
    }
    
    
    static func download(url: URL) -> AnyPublisher<Data, any Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap({ try handleURLResponse(output: $0, url: url) })
            .retry(3)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    static func handleURLResponse(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data{
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode <= 300 else{
            throw NetworkingError.badURLResponse(url: url)
        }
        return output.data
    }
    
    static func handleCompletion(completion: Subscribers.Completion<Error>){
        switch completion{
        case .finished:
            break
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
}
