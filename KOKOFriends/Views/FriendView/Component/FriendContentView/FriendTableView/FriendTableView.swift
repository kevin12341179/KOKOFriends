//
//  FriendTableView.swift
//  KOKOFriends
//
//  Created by YU TSEN LIN on 2023/5/28.
//

import UIKit

protocol FriendTableViewDelegate: AnyObject {
}

protocol FriendTableViewInterFace {
    func setFriendData(data: [Friend])
}

class FriendTableView: UIView, NibOwnerLoadable{
    
    @IBOutlet weak var tableView: UITableView!
    
    var tableviewData: [Friend] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadNibContent()
        initView()
    }
    
    func initView(){
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName:
                                        "FriendTableViewCell", bundle:nil), forCellReuseIdentifier: "cell")
    }
}

extension FriendTableView: FriendTableViewInterFace {
    func setFriendData(data: [Friend]) {
        self.tableviewData = data
        self.tableView.reloadData()
    }
}

extension FriendTableView: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableviewData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? FriendTableViewCell {
            cell.setCellData(data: tableviewData[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
}

extension FriendTableView: FriendTableViewDelegate{
    
}
