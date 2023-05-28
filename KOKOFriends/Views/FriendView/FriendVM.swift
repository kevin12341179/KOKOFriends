//
//  FriendVM.swift
//  KOKOFriends
//
//  Created by Kevin_Hsu on 2023/5/26.
//

import Foundation
import Combine

enum getFriendListType {
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
    func getFriendList(type: getFriendListType)
    var friendListPublisher: Published<[Friend]>.Publisher { get }
}

class FrinedVM: FrinedVMInterFace {
    // User
    @Published private var _user: User = User.defaultUser
    var userPublisher: Published<User>.Publisher { $_user }
    // Friend
    @Published private var _friendList: [Friend] = []
    var friendListPublisher: Published<[Friend]>.Publisher { $_friendList }
    
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
    
    func getFriendList(type: getFriendListType) {
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
                self._friendList = data
            }
            .store(in: &cancellable)
    }
    
    func _getFriendListSwitch(type: getFriendListType) -> AnyPublisher<[Friend], Error> {
        switch type {
        case .One:
            return friendRepository.getFriendList1()
        case .Two, .Three:
            return Publishers.CombineLatest(friendRepository.getFriendList2(), friendRepository.getFriendList3())
                .map { (data2, data3) in
                    var mergedFriends = data2 + data3
                    var filteredFriends: [String: Friend] = [:]
                    for friend in mergedFriends {
                        if let existingFriend = filteredFriends[friend.fid] {
                            let existingUpdateDate = existingFriend.updateDate.split(separator: "/").reduce("", {String($0) + String($1)})
                            let currentUpdateDate = friend.updateDate
                            
                            if Int(existingUpdateDate) ?? 0 < Int(currentUpdateDate) ?? 0 {
                                // 如果現在的updateDate較新，則取代原本的資料
                                filteredFriends[friend.fid] = friend
                            }
                        } else {
                            // 如果fid沒有重複，則直接加入到filteredFriends中
                            filteredFriends[friend.fid] = friend
                        }
                    }
                    return Array(filteredFriends.values)
                }
                .eraseToAnyPublisher()
        case .Four:
            return friendRepository.getFriendList4()
        }
    }
}
