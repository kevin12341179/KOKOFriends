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
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: "FriendVC", bundle: Bundle.main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("FriendVC init(coder:) has not been implemented")
    }
    
    // Base
    var viewModel: FrinedVMInterFace = FrinedVM()
    var cancellable = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.rgbaColor(r: 252, g: 252, b: 252)
        
        bindViewModel()
    }
    
    func bindViewModel(){
        viewModel.userPublisher
            .receive(on: DispatchQueue.main)
            .sink {[weak self] data in
                self?.userView.setUser(user: data)
            }
            .store(in: &cancellable)
        viewModel.getUser()
    }
}
