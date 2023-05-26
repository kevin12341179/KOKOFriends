//
//  FriendsResponse.swift
//  KOKOFriends
//
//  Created by Kevin_Hsu on 2023/5/26.
//

import Foundation
import Combine

protocol FriendsRepositoryInterFace {
    // 好友列表
    func getFriendList1() -> AnyPublisher<[Friend], Error>
    func getFriendList2() -> AnyPublisher<[Friend], Error>
    // 好友列表含邀請列表
    func getFriendList3() -> AnyPublisher<[Friend], Error>
    // 無資料邀請/好友列表
    func getFriendList4() -> AnyPublisher<[Friend], Error>
}

class FriendsRepository: FriendsRepositoryInterFace{
    static let shared = FriendsRepository()
    
    func getFriendList1() -> AnyPublisher<[Friend], Error> {
        return APIManager.shared.requestAPI(urlstring: APIInfo.getFriendList1)
            .map({$0.response})
            .eraseToAnyPublisher()
    }
    
    func getFriendList2() -> AnyPublisher<[Friend], Error> {
        return APIManager.shared.requestAPI(urlstring: APIInfo.getFriendList2)
            .map({$0.response})
            .eraseToAnyPublisher()
    }
    
    func getFriendList3() -> AnyPublisher<[Friend], Error> {
        return APIManager.shared.requestAPI(urlstring: APIInfo.getFriendList3)
            .map({$0.response})
            .eraseToAnyPublisher()
    }
    
    func getFriendList4() -> AnyPublisher<[Friend], Error> {
        return APIManager.shared.requestAPI(urlstring: APIInfo.getFriendList4)
            .map({$0.response})
            .eraseToAnyPublisher()
    }
}
