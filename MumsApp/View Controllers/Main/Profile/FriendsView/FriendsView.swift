import UIKit

class FriendsView: UIView {
    
    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var sendMessageButton: UIButton!
    
    var members: Array<UIImage> = []
    
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
        
        // OPEN CHAT
        
    }
    
}

extension FriendsView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        //        return self.members.count
        return 8 // max 8
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableClass(MembersCell.self, forIndexPath: indexPath, type: .cell)
        
        return cell
        
    }
    
}
