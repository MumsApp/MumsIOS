import UIKit

class AddProductImagesView: UIView {
    
    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var images: Array<UIImage> = []
    
    var delegate: AddImageCellDelegate?
    
    var imageCellDelegate: ImageCellDelegate?
    
    func configureWith(delegate: AddImageCellDelegate?, imageCellDelegate: ImageCellDelegate?) {
        
        self.delegate = delegate
        
        self.imageCellDelegate = imageCellDelegate
        
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
        
        Bundle.main.loadNibNamed("AddProductImagesView", owner: self, options: nil)
        
        self.addSubview(self.contentView)
        
        self.contentView.frame = self.bounds
        
        self.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        self.configureView()
        
    }
    
    func configureView() {
        
        self.backgroundColor = .clear

        self.titleLabel.font = .semiBold(size: 17)
     
        self.collectionView.register(AddImageCell.self, type: .cell)
        
        self.collectionView.register(ImageCell.self, type: .cell)
    
        self.collectionView.delegate = self
        
        self.collectionView.dataSource = self

        self.collectionView.addShadow()
        
    }
    
}

extension AddProductImagesView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.images.count + 1
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.row == 0 {
            
            let cell = collectionView.dequeueReusableClass(AddImageCell.self, forIndexPath: indexPath, type: .cell)
            
            cell.configureWith(delegate: self.delegate)
            
            return cell
            
        } else {
            
            let cell = collectionView.dequeueReusableClass(ImageCell.self, forIndexPath: indexPath, type: .cell)
            
            let thisImage = self.images[indexPath.row - 1]
            
            cell.configureWith(delegate: self.imageCellDelegate, tag: indexPath.row - 1)
            
            cell.itemButton.setImage(thisImage, for: .normal)
            
            if indexPath.row == 1 {
                
                cell.layer.borderColor = UIColor.mainGreen.cgColor
                
                cell.layer.borderWidth = 3
            
            } else {
                
                cell.layer.borderColor = .none
                
                cell.layer.borderWidth = 0

            }
        
            return cell
            
        }
        
    }
    
}
