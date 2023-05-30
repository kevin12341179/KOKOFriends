//
//  AddFriendCell.swift
//  KOKOFriends
//
//  Created by Kevin_Hsu on 2023/5/30.
//

import UIKit

class AddFriendCell: UITableViewCell {
    @IBOutlet weak var userName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    func setData(data: Friend){
        self.userName.text = data.name
    }
}
