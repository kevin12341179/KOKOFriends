//
//  AddFriendView.swift
//  KOKOFriends
//
//  Created by Kevin_Hsu on 2023/5/29.
//

import UIKit

protocol AddFriendViewDelegate: AnyObject {
    func setExpand(isExpand: Bool)
}

class AddFriendView: UIView, NibOwnerLoadable {
    @IBOutlet weak var tableView: UITableView!
    
    weak var delegate: AddFriendViewDelegate?
    var isExpand: Bool = false
    var friendData: [Friend] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadNibContent()
        initView()
    }
    
    func initView(){
        self.tableView.register(UINib(nibName: "AddFriendSection", bundle: nil), forHeaderFooterViewReuseIdentifier: "SectionView")
        self.tableView.register(UINib(nibName: "AddFriendCell", bundle: nil), forCellReuseIdentifier: "cell")
        if #available(iOS 15.0, *) {
            self.tableView.sectionHeaderTopPadding = 0
        }
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    func setData(data: [Friend]) {
        self.isExpand = false
        self.friendData = data
        self.tableView.reloadData()
    }
    
    func _clickHeaderOrCell(){
        isExpand = !isExpand
        delegate?.setExpand(isExpand: isExpand)
        self.tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
    }
}

extension AddFriendView: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let friendData = friendData.first, let sectionView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "SectionView") as? AddFriendSection {
            sectionView.setSectionData(delegate: self, data: friendData)
            return sectionView
        }
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return isExpand ? 0 : 130
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isExpand ? self.friendData.count + 1 : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row != 0, let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? AddFriendCell {
            cell.setData(data: self.friendData[indexPath.row - 1])
            return cell
        }
        
        let cell = UITableViewCell()
        cell.backgroundColor = UIColor.rgbaColor(r: 252, g: 252, b: 252)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return isExpand ? indexPath.row == 0 ? 15 : 90 : 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        _clickHeaderOrCell()
    }
}

extension AddFriendView: AddFriendSectionDelegate {
    func headerClick() {
        _clickHeaderOrCell()
    }
}
