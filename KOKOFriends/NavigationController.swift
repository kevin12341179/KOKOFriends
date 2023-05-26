//
//  NavigationController.swift
//  KOKOFriends
//
//  Created by YU TSEN LIN on 2023/5/25.
//

import UIKit

class NavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setbackgroundColor(color: UIColor.rgbaColor(r: 252, g: 252, b: 252))
        self.setLeftButton()
        self.setRightButton()
    }

}
