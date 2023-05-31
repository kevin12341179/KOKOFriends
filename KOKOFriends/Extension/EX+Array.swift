//
//  EX+Array.swift
//  KOKOFriends
//
//  Created by Kevin_Hsu on 2023/5/31.
//

import Foundation

extension Collection where Indices.Iterator.Element == Index {
    subscript (exist index: Index) -> Iterator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
