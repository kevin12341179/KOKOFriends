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
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
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
        if let sectionView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "SectionView") as? AddFriendSection {
            sectionView.delegate = self
            return sectionView
        }
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return isExpand ? 0 : 130
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isExpand ? 5 : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.backgroundColor = .red
        return cell
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
