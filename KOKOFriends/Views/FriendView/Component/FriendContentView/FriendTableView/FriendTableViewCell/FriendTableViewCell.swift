//
//  FriendTableViewCell.swift
//  KOKOFriends
//
//  Created by YU TSEN LIN on 2023/5/28.
//

import UIKit

class FriendTableViewCell: UITableViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var invaiteBtn: UIButton!
    @IBOutlet weak var moreView: UIView!
    @IBOutlet weak var starView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setCellData(data: Friend){
        self.name.text = data.name
        self.invaiteBtn.isHidden = data.status != 2
        self.moreView.isHidden = data.status != 1
        self.starView.isHidden = data.isTop == "0"
    }
}
