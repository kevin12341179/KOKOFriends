//
//  FriendTableView.swift
//  KOKOFriends
//
//  Created by YU TSEN LIN on 2023/5/28.
//

import UIKit

protocol FriendTableViewDelegate: AnyObject {
    func getFriendList(type: GetFriendListType)
}

protocol FriendTableViewInterFace {
    func setDelegate(delegate: FriendTableViewDelegate)
    func setFriendData(data: [Friend], getFriendListType: GetFriendListType)
}

class FriendTableView: UIView, NibOwnerLoadable{
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    weak var delegate: FriendTableViewDelegate?
    
    var getFriendListType: GetFriendListType = .One
    var refreshControl: UIRefreshControl = UIRefreshControl()
    var tableviewData: [Friend] = []
    var showData: [Friend] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadNibContent()
        initView()
    }
    
    func initView(){
        self.textField.delegate = self
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName:
                                        "FriendTableViewCell", bundle:nil), forCellReuseIdentifier: "cell")
        self.tableView.refreshControl = refreshControl
        self.tableView.refreshControl?.addTarget(self, action:
                                                #selector(onRefresh),
                                             for: .valueChanged)
    }
    
    @objc func onRefresh() {
        switch getFriendListType {
        case .One, .Two:
            self.delegate?.getFriendList(type: .Three)
        case .Three:
            self.delegate?.getFriendList(type: .Four)
        case .Four:
            self.delegate?.getFriendList(type: .One)
        }
    }
}

extension FriendTableView: FriendTableViewInterFace {
    func setDelegate(delegate: FriendTableViewDelegate) {
        self.delegate = delegate
    }
    
    func setFriendData(data: [Friend], getFriendListType: GetFriendListType) {
        self.getFriendListType = getFriendListType
        self.tableviewData = data
        self._checkSearch(textField: textField)
        self.refreshControl.endRefreshing()
    }
}

extension FriendTableView: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return showData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? FriendTableViewCell {
            cell.setCellData(data: showData[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
}

extension FriendTableView: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.3, animations: {
            self.frame.origin.y = self.frame.origin.y - 150
        })
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        UIView.animate(withDuration: 0.3, animations: {
            self.frame.origin.y = self.frame.origin.y + 150
        })
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        _checkSearch(textField: textField)
    }
    
    func _checkSearch(textField: UITextField){
        if let stg = textField.text, !stg.isEmpty {
            showData = tableviewData.filter({ f in
                return f.name.contains(stg)
            })
        } else {
            showData = tableviewData
        }
        tableView.reloadData()
    }
}
