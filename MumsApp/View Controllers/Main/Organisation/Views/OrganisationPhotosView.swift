import UIKit

class OrganisationPhotosView: UIView {
    
    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var images: Array<UIImage> = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.commonInit()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.commonInit()
        
    }
    
    private func commonInit() {
        
        Bundle.main.loadNibNamed("OrganisationPhotosView", owner: self, options: nil)
        
        self.addSubview(self.contentView)
        
        self.contentView.frame = self.bounds
        
        self.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        self.configureView()
        
    }
    
    func configureView() {
        
        self.backgroundColor = .clear
        
        self.titleLabel.font = .semiBold(size: 17)
        
        self.collectionView.register(ImageCell.self, type: .cell)
     
        self.collectionView.delegate = self
        
        self.collectionView.dataSource = self
        
    }
    
}

extension OrganisationPhotosView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 5
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableClass(ImageCell.self, forIndexPath: indexPath, type: .cell)
        
//        let thisImage = self.images[indexPath.row - 1]
        
//        cell.itemButton.setImage(thisImage, for: .normal)
        
        cell.itemButton.isUserInteractionEnabled = false
        
        cell.deleteButton.isHidden = true
        
        return cell
        
    }
    
}
