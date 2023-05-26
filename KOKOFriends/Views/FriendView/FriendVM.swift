//
//  FriendVM.swift
//  KOKOFriends
//
//  Created by Kevin_Hsu on 2023/5/26.
//

import Foundation
import Combine

protocol FrinedVMInterFace {
    // User
    func getUser()
    var userPublisher: Published<User>.Publisher { get }
}

class FrinedVM: FrinedVMInterFace {
    // User
    @Published private var _user: User = User.defaultUser
    var userPublisher: Published<User>.Publisher { $_user }
    
    private let userRepository: UserRepositoryInterFace
    var cancellable = Set<AnyCancellable>()
    
    init(
        userRepository: UserRepositoryInterFace = UserRepository.shared)
    {
        self.userRepository = userRepository
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
}
