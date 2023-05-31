//
//  MockManger.swift
//  KOKOFriends
//
//  Created by Kevin_Hsu on 2023/5/31.
//

import Foundation
import Combine

class MockManger {
    static let shared = MockManger()

    func requestMockAPI<T: Codable>(urlstring: String) -> AnyPublisher<APIResponse<T>, Error> {
        guard let url = URL(string: urlstring) else {
            return Fail(error: ErrorType.UrlError).eraseToAnyPublisher()
        }
        
        let mockFile = _getMockFile(urlstring: urlstring)
        if !mockFile.isEmpty, let path = Bundle.main.path(forResource: mockFile, ofType: "json"){
            let url = URL(fileURLWithPath: path)
            return URLSession.shared.dataTaskPublisher(for: url)
                .map({$0.data})
                .decode(type: APIResponse<T>.self, decoder: JSONDecoder())
                .eraseToAnyPublisher()
        } else {
            return URLSession.shared.dataTaskPublisher(for: url)
                .map({$0.data})
                .decode(type: APIResponse<T>.self, decoder: JSONDecoder())
                .eraseToAnyPublisher()
        }
    }
    
    func _getMockFile(urlstring: String) -> String {
        if urlstring.contains("/man.json") {
            return "MockUser"
        }
        
        if urlstring.contains("/friend3.json") {
            return "MockFriendList"
        }
        
        return ""
    }
}
