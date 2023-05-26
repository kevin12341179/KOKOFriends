//
//  APIResponse.swift
//  KOKOFriends
//
//  Created by Kevin_Hsu on 2023/5/26.
//

import Foundation

struct APIResponse<T:Codable>: Codable{
    var response: T
}
