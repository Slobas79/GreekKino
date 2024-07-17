//
//  ReactiveNetworkingService.swift
//  GreekKino
//
//  Created by Slobodan Stamenic on 16.7.24..
//

import Foundation
import Combine

protocol ReactiveNetworkingService: NetworkingService {
    func request<T: Decodable>(_ returnType: T.Type, requestable: RequestConvertible) -> AnyPublisher<T, Error>
}

class ReactiveNetworkingServiceImpl: ReactiveNetworkingService {
    private let session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func request<T: Decodable>(_ returnType: T.Type, requestable: RequestConvertible) -> AnyPublisher<T, Error> {
        do {
            let request = try requestable.toURLRequest()
            
            return session.dataTaskPublisher(for: request)
                .tryMap {[weak self] element -> Data in
                    guard let self = self else { return Data() }
                    try self.validateResponse(data: element.data, response: element.response)
                    
                    return element.data
                }
                .decode(type: returnType, decoder: JSONDecoder())
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: error).eraseToAnyPublisher()
        }
    }
}

