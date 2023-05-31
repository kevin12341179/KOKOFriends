//
//  FriendVC.swift
//  KOKOFriends
//
//  Created by Kevin_Hsu on 2023/5/26.
//

import UIKit
import Combine

class FriendVC: UIViewController {
    
    @IBOutlet weak var userView: UserView!
    @IBOutlet weak var frinedContentView: FriendContentView!
    @IBOutlet weak var addFriendView: AddFriendView!
    @IBOutlet weak var spaceView: UIView!
    @IBOutlet weak var addFriendViewHeight: NSLayoutConstraint!
    
    init(viewModel: FrinedVMInterFace) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: "FriendVC", bundle: Bundle.main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("FriendVC init(coder:) has not been implemented")
    }
    
    // Base
    var viewModel: FrinedVMInterFace?
    var cancellable = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.rgbaColor(r: 252, g: 252, b: 252)
        
        frinedContentView.delegate = self
        addFriendView.delegate = self
        
        bindViewModel()
    }
    
    func bindViewModel(){
        viewModel?.userPublisher
            .receive(on: DispatchQueue.main)
            .sink {[weak self] data in
                self?.userView.setUser(user: data)
            }
            .store(in: &cancellable)
        viewModel?.getUser()
        
        viewModel?.friendListPublisher
            .receive(on: DispatchQueue.main)
            .sink {[weak self] (data, type) in
                // 下方
                self?.frinedContentView.setData(friendData: data, getFriendListType: type)
                // 邀請
                let invitaeList = data.filter { f in
                    return f.status == 0
                }
                if invitaeList.isEmpty {
                    self?.addFriendView.isHidden = true
                    self?.spaceView.isHidden = false
                } else {
                    self?.addFriendView.isHidden = false
                    self?.spaceView.isHidden = true
                    self?.addFriendViewHeight.constant = 130
                    self?.addFriendView.setData(data: invitaeList)
                }
            }
            .store(in: &cancellable)
        viewModel?.getFriendList(type: .Four)
    }
}

extension FriendVC: FriendContentDelegate {
    func getCompontHeight() -> CGFloat {
        return (self.addFriendView.isHidden ? 0 : self.addFriendViewHeight.constant) + self.userView.bounds.height
    }
    
    func getFriendList(type: GetFriendListType) {
        self.viewModel?.getFriendList(type: type)
    }
}

extension FriendVC: AddFriendViewDelegate {
    func setExpand(isExpand: Bool) {
        self.addFriendViewHeight.constant = isExpand ? 200 : 130
    }
}
