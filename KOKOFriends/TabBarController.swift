//
//  TabBarController.swift
//  KOKOFriends
//
//  Created by Kevin_Hsu on 2023/5/25.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setBackgroundColor(.white)
        
        let viewController1 = UIViewController()
        let viewController2 = FriendVC()
        let viewController3 = UIViewController()
        let viewController4 = UIViewController()
        let viewController5 = UIViewController()

        viewController1.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "icTabbarProductsOff")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "icTabbarProductsOff")?.withRenderingMode(.alwaysOriginal))
        viewController2.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "icTabbarFriendsOn")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "icTabbarFriendsOn")?.withRenderingMode(.alwaysOriginal))
        viewController3.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "icTabbarHomeOff")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "icTabbarHomeOff")?.withRenderingMode(.alwaysOriginal))
        viewController3.tabBarItem.imageInsets = UIEdgeInsets(top: -10, left: 0, bottom: 0, right: 0)
        viewController4.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "icTabbarManageOff")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "icTabbarManageOff")?.withRenderingMode(.alwaysOriginal))
        viewController5.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "icTabbarSettingOff")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "icTabbarSettingOff")?.withRenderingMode(.alwaysOriginal))
        
        self.viewControllers = [viewController1, viewController2, viewController3, viewController4, viewController5]
        self.selectedIndex = 1
    }
    
}
