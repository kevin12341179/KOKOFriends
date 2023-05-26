//
//  APIInfo.swift
//  KOKOFriends
//
//  Created by Kevin_Hsu on 2023/5/26.
//

struct APIInfo {
    static let domain : String = "https://dimanyen.github.io"
    // 使用者資料
    static let getUserData = domain + "/man.json"
    // 好友列表
    static let getFriendList1 = domain + "/friend1.json"
    static let getFriendList2 = domain + "/friend2.json"
    // 好友列表含邀請列表
    static let getFriendList3 = domain + "/friend3.json"
    // 無資料邀請/好友列表
    static let getFriendList4 = domain + "/friend4.json"
}
