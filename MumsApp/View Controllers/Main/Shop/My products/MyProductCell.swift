import UIKit

class MyProductCell: UICollectionViewCell, Reusable {
    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var itemImageView: UIImageView!
    
    @IBOutlet weak var editButton: UIButton!
    
    @IBOutlet weak var itemNameLabel: UILabel!
    
    @IBOutlet weak var itemCategoryLabel: UILabel!
    
    @IBOutlet weak var itemPriceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.configureView()
        
    }
    
    private func configureView() {
        
//        self.selectionStyle = .none
        
        self.backgroundColor = .clear
        
        self.containerView.addShadow()
        
        self.itemImageView.layer.cornerRadius = 4
        
        self.itemImageView.layer.masksToBounds = true
        
        self.itemNameLabel.font = .regular(size: 15)
        
        self.itemCategoryLabel.font = .regular(size: 12)
        
        self.itemCategoryLabel.textColor = .mainDarkGrey
        
        self.itemPriceLabel.font = .regular(size: 15)
        
    }
    
    @IBAction func editButtonPressed(_ sender: UIButton) {
    
    }
    
}

