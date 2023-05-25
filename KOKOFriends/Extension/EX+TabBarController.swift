//
//  Extension+UITabBarController.swift
//  KOKOFriends
//
//  Created by YU TSEN LIN on 2023/5/25.
//

import UIKit

extension UITabBarController {
    func setBackgroundColor(_ color: UIColor) {
        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = color
            
            self.tabBar.standardAppearance = appearance
            self.tabBar.scrollEdgeAppearance = appearance
        }else {
            self.tabBar.barTintColor = UIColor.white
        }
        self.tabBar.isTranslucent = false
    }
}
