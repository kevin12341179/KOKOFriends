//
//  AddFriendSection.swift
//  KOKOFriends
//
//  Created by Kevin_Hsu on 2023/5/29.
//

import UIKit

protocol AddFriendSectionDelegate: AnyObject {
    func headerClick()
}

class AddFriendSection: UITableViewHeaderFooterView {
    
    weak var delegate: AddFriendSectionDelegate?
    
    @IBAction func headerClick(_ sender: Any) {
        delegate?.headerClick()
    }
}
