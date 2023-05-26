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
                    let tempData3 = data3
                    data2.map { friend2 in
                        if let i = data3.firstIndex(where: { friend3 in
                            return friend3.fid == friend2.fid
                        }){
                            
                        }
                    }
                    
                    return data2
                }
                .eraseToAnyPublisher()
        case .Four:
            return friendRepository.getFriendList4()
        }
    }
}
