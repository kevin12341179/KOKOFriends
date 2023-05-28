//
//  FriendContentView.swift
//  KOKOFriends
//
//  Created by Kevin_Hsu on 2023/5/26.
//

import UIKit

protocol FriendContentDelegate: AnyObject {
    func getFriendList(type: getFriendListType)
}

enum FriendContent: String{
    case Friend = "好友"
    case Talk = "聊天"
}

class FriendContentView: UIView, NibOwnerLoadable {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var noDataView: UIView!
    @IBOutlet var contentViews: [UIView]!
    
    weak var delegate: FriendContentDelegate?
    
    let contents: [FriendContent] = [.Friend, .Talk]
    var select: FriendContent = .Friend
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
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(UINib(nibName:
                                            "FrinedContentCell", bundle:nil),
                                     forCellWithReuseIdentifier: "cell")
    }
    
    func setData(friendData: [Friend]){
        self.friendData = friendData
        self.noDataView.isHidden = self.friendData.count > 0
        
        if let friendTBV = contentViews[0] as? FriendTableViewInterFace {
            friendTBV.setFriendData(data: friendData)
        }
    }
    
    @IBAction func addFriendClick(_ sender: Any) {
        self.delegate?.getFriendList(type: .One)
    }
}

extension FriendContentView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return contents.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:50, height:self.collectionView.bounds.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? FrinedContentCell {
            cell.setSelect(isSelect: select == contents[indexPath.row])
            cell.setTitle(title: contents[indexPath.row].rawValue)
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        select = contents[indexPath.row]
        collectionView.reloadData()
    }
}
