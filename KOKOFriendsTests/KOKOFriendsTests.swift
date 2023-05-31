//
//  KOKOFriendsTests.swift
//  KOKOFriendsTests
//
//  Created by Kevin_Hsu on 2023/5/25.
//

import XCTest
import Combine
@testable import KOKOFriends


class KOKOFriendsTests: XCTestCase {
    var userRepo: UserRepositoryInterFace!
    var friendRepo: FriendsRepositoryInterFace!
    var cancellable: Set<AnyCancellable>!
    
    override func setUpWithError() throws {
        self.userRepo = UserRepository.shared
        self.friendRepo = FriendsRepository.shared
        self.cancellable = Set<AnyCancellable>()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        self.cancellable = nil
    }

    func test_getUser() throws {
        let expect = expectation(description: #function)
        var result = User.defaultUser

        userRepo.getUser()
            .sink { completion in
                switch completion {
                case .failure(_):
                    // do error things
                    break
                case .finished:
                    break
                }
            } receiveValue: { data in
                result = data.first ?? User.defaultUser
                expect.fulfill()
            }
            .store(in: &cancellable)

        waitForExpectations(timeout: 30.0) { error in
            XCTAssertTrue(error == nil)
            XCTAssertEqual(result.name, "Mock國泰")
            XCTAssertEqual(result.kokoid, "MockMike")
        }
    }
    
    func test_getFriendList() throws {
        let expect = expectation(description: #function)
        var result: [Friend] = []
        
        friendRepo.getFriendList3()
            .sink { completion in
                switch completion {
                case .failure(let error):
                    // do error things
                    var a = error
                    break
                case .finished:
                    break
                }
            } receiveValue: { data in
                result = data
                expect.fulfill()
            }
            .store(in: &cancellable)
        
        waitForExpectations(timeout: 30.0) { error in
            XCTAssertTrue(error == nil)
            XCTAssertEqual(result.count, 2)
            XCTAssertEqual(result[exist: 0]?.name, "Test黃靖僑")
            XCTAssertEqual(result[exist: 1]?.name, "Test翁勳儀")
        }
    }
}
