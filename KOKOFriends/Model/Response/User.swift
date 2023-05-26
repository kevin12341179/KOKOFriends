//
//  User.swift
//  KOKOFriends
//
//  Created by Kevin_Hsu on 2023/5/26.
//

import Foundation

struct User: Codable{
    var name: String
    var kokoid: String
    
    static var defaultUser: User {
        return User(name: "", kokoid: "")
    }
}
