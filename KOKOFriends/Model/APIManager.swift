//
//  APIManager.swift
//  KOKOFriends
//
//  Created by Kevin_Hsu on 2023/5/26.
//

import Foundation
import Combine

enum ErrorType: Error{
    case UrlError
    case ApiError
}

class APIManager {
    static let shared = APIManager()

    func requestAPI<T: Codable>(urlstring: String) -> AnyPublisher<APIResponse<T>, Error> {
        guard let url = URL(string: urlstring) else {
            return Fail(error: ErrorType.UrlError).eraseToAnyPublisher()
        }
        
        if let _ = NSClassFromString("XCTestCase") {
            return MockManger.shared.requestMockAPI(urlstring: urlstring)
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map({$0.data})
            .decode(type: APIResponse<T>.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
