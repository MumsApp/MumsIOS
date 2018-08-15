import UIKit

protocol FriendsViewDelegate: class {
    
    func sendMessageButtonPressed()
    
}

class FriendsView: UIView {
    
    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var sendMessageButton: UIButton!
    
    private weak var delegate: FriendsViewDelegate?

    var friends: Array<Friend> = []

    func configureWith(delegate: FriendsViewDelegate? = nil) {
        
        self.delegate = delegate
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.commonInit()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.commonInit()
        
    }
    
    private func commonInit() {
        
        Bundle.main.loadNibNamed("FriendsView", owner: self, options: nil)
        
        self.addSubview(self.contentView)
        
        self.contentView.frame = self.bounds
        
        self.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        self.configureView()
        
    }
    
    func configureView() {
        
        self.backgroundColor = .clear
        
        self.titleLabel.font = .semiBold(size: 15)
                        
        self.collectionView.register(MembersCell.self, type: .cell)
        
        self.collectionView.delegate = self
        
        self.collectionView.dataSource = self
        
    }
    
    @IBAction func sendMessageButtonPressed(_ sender: UIButton) {
        
        self.delegate?.sendMessageButtonPressed()
        
    }
    
}

extension FriendsView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.friends.count

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableClass(MembersCell.self, forIndexPath: indexPath, type: .cell)
        
        let friend = self.friends[indexPath.row]
        
        cell.configureWith(friend: friend)
        
        return cell
        
    }
    
}
