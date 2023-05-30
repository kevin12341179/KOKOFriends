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
    @IBOutlet weak var cardView: UIView!
    
    weak var delegate: AddFriendSectionDelegate?
    
    func setSectionData(delegate: AddFriendSectionDelegate, data: Friend){
        self.delegate = delegate
    }
    
    @IBAction func headerClick(_ sender: Any) {
        delegate?.headerClick()
    }
}
