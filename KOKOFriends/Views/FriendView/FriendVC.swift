//
//  FriendVC.swift
//  KOKOFriends
//
//  Created by Kevin_Hsu on 2023/5/26.
//

import UIKit

class FriendVC: UIViewController {
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: "FriendVC", bundle: Bundle.main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("FriendVC init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.rgbaColor(r: 252, g: 252, b: 252)
    }
}
