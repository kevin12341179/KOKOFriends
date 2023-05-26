//
//  Extension+UINavigationController.swift
//  KOKOFriends
//
//  Created by YU TSEN LIN on 2023/5/25.
//

import UIKit

extension UINavigationController {
    func setbackgroundColor(color: UIColor){
        if #available(iOS 15.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = color
            appearance.shadowImage = UIImage()
            appearance.shadowColor = .clear
            
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        } else {
            UINavigationBar.appearance().barTintColor = color
            UINavigationBar.appearance().shadowImage = UIImage()
        }
    }
    
    func setLeftButton(){
        let atmBtn = UIButton()
        atmBtn.setImage(UIImage(named: "icNavPinkWithdraw"), for: .normal)
        atmBtn.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
        atmBtn.addTarget(self, action: #selector(clickATM), for: .touchUpInside)
        
        let moneyBtn = UIButton()
        moneyBtn.setImage(UIImage(named: "icNavPinkTransfer"), for: .normal)
        moneyBtn.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
        moneyBtn.addTarget(self, action: #selector(clickMoney), for: .touchUpInside)
        
        let stackview = UIStackView.init(arrangedSubviews: [atmBtn, moneyBtn])
        stackview.distribution = .equalSpacing
        stackview.axis = .horizontal
        stackview.alignment = .center
        stackview.spacing = 24
        let leftBarButton = UIBarButtonItem(customView: stackview)
        
        self.visibleViewController?.navigationItem.leftBarButtonItem = leftBarButton
    }
    
    func setRightButton(){
        let scanBtn = UIButton()
        scanBtn.setImage(UIImage(named: "icNavPinkScan"), for: .normal)
        scanBtn.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
        scanBtn.addTarget(self, action: #selector(clickScan), for: .touchUpInside)
        let scanItem = UIBarButtonItem(customView: scanBtn)
        
        self.visibleViewController?.navigationItem.rightBarButtonItem = scanItem
    }
    
    @objc private func clickATM(sender:UIButton) {
        print("@@@ ATM @@@")
    }
    
    @objc private func clickMoney(sender:UIButton) {
        print("@@@ Money @@@")
    }
    
    @objc private func clickScan(sender:UIButton) {
        print("@@@ Scan @@@")
    }
}
