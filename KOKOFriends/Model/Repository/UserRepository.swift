//
//  UserResponse.swift
//  KOKOFriends
//
//  Created by Kevin_Hsu on 2023/5/26.
//

import Foundation
import Combine

protocol UserRepositoryInterFace {
    func getUser() -> AnyPublisher<[User], Error>
}

class UserRepository: UserRepositoryInterFace{
    static let shared = UserRepository()
    
    func getUser() -> AnyPublisher<[User], Error> {
        return APIManager.shared.requestAPI(urlstring: APIInfo.getUserData)
            .map({$0.response})
            .eraseToAnyPublisher()
    }
}
