//
//  FriendVM.swift
//  KOKOFriends
//
//  Created by Kevin_Hsu on 2023/5/26.
//

import Foundation
import Combine

enum GetFriendListType {
    case One
    case Two
    case Three
    case Four
}

protocol FrinedVMInterFace {
    // User
    func getUser()
    var userPublisher: Published<User>.Publisher { get }
    
    // Friend
    func getFriendList(type: GetFriendListType)
    var friendListPublisher: Published<([Friend], GetFriendListType)>.Publisher { get }
}

class FrinedVM: FrinedVMInterFace {
    // User
    @Published private var _user: User = User.defaultUser
    var userPublisher: Published<User>.Publisher { $_user }
    // Friend
    @Published private var _friendList: ([Friend], GetFriendListType) = ([], .Four)
    var friendListPublisher: Published<([Friend], GetFriendListType)>.Publisher { $_friendList }
    
    private let userRepository: UserRepositoryInterFace
    private let friendRepository: FriendsRepositoryInterFace
    var cancellable = Set<AnyCancellable>()
    
    init(
        userRepository: UserRepositoryInterFace = UserRepository.shared,
        friendRepository: FriendsRepositoryInterFace = FriendsRepository.shared
    )
    {
        self.userRepository = userRepository
        self.friendRepository = friendRepository
    }
    
    func getUser() {
        userRepository.getUser()
            .sink { completion in
                switch completion {
                case .failure(_):
                    // do error things
                    break
                case .finished:
                    break
                }
            } receiveValue: { data in
                self._user = data.first ?? User.defaultUser
            }
            .store(in: &cancellable)
    }
    
    func getFriendList(type: GetFriendListType) {
        _getFriendListSwitch(type: type)
            .sink { completion in
                switch completion {
                case .failure(_):
                    // do error things
                    break
                case .finished:
                    break
                }
            } receiveValue: { data in
                self._friendList = (data, type)
            }
            .store(in: &cancellable)
    }
    
    func _getFriendListSwitch(type: GetFriendListType) -> AnyPublisher<[Friend], Error> {
        switch type {
            // 這邊呼叫的情境沒有下拉刷新的使用者體驗所以不加延遲
        case .One, .Two:
            return Publishers.CombineLatest(friendRepository.getFriendList1(), friendRepository.getFriendList2())
                .map { (data1, data2) in
                    let mergedFriends = data1 + data2
                    var filteredFriends: [String: Friend] = [:]
                    for friend in mergedFriends {
                        if let existingFriend = filteredFriends[friend.fid] {
                            let existingUpdateDate = existingFriend.updateDate.split(separator: "/").reduce("", {String($0) + String($1)})
                            let currentUpdateDate = friend.updateDate.split(separator: "/").reduce("", {String($0) + String($1)})
                            
                            if Int(existingUpdateDate) ?? 0 < Int(currentUpdateDate) ?? 0 {
                                filteredFriends[friend.fid] = friend
                            }
                        } else {
                            filteredFriends[friend.fid] = friend
                        }
                    }
                    return Array(filteredFriends.values)
                }
                .eraseToAnyPublisher()
        case .Three:
            return friendRepository.getFriendList3()
                .delay(for: 1, scheduler: DispatchQueue.global())
                .eraseToAnyPublisher()
        case .Four:
            return friendRepository.getFriendList4()
                .delay(for: 1, scheduler: DispatchQueue.global())
                .eraseToAnyPublisher()
        }
    }
}
