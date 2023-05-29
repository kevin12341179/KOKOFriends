//
//  FrinedContentCell.swift
//  KOKOFriends
//
//  Created by Kevin_Hsu on 2023/5/26.
//

import UIKit

class FrinedContentCell: UICollectionViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var selectView: UIView!
    @IBOutlet weak var bubbleView: UIView!
    @IBOutlet weak var numberTitle: UILabel!
    
    func setTitle(title: String){
        self.title.text = title
    }
    
    func setSelect(isSelect: Bool){
        selectView.isHidden = !isSelect
        self.title.font = isSelect ? UIFont.systemFont(ofSize: 13, weight: .medium) : UIFont.systemFont(ofSize: 13, weight: .regular)
    }
    
    func setNumber(num: Int){
        self.bubbleView.isHidden = num <= 0
        self.numberTitle.text = String(num) + (num >= 99 ? "+" : "")
    }
}
