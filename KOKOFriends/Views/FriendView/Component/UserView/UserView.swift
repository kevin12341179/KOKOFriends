//
//  UserView.swift
//  KOKOFriends
//
//  Created by Kevin_Hsu on 2023/5/26.
//

import UIKit

class UserView: UIView, NibOwnerLoadable {

    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userID: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadNibContent()
    }
    
    func setUser(user: User){
        userName.text = user.name
        userID.text = "KOKO ID : \(user.kokoid)"
    }
}
