import UIKit

protocol MyProductCellDelegate: class {
    
    func editButtonPressed(product: Product)
    
}

class MyProductCell: UICollectionViewCell, Reusable {
    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var itemImageView: LoadableImageView!
    
    @IBOutlet weak var editButton: UIButton!
    
    @IBOutlet weak var itemNameLabel: UILabel!
    
    @IBOutlet weak var itemCategoryLabel: UILabel!
    
    @IBOutlet weak var itemPriceLabel: UILabel!
    
    private weak var delegate: MyProductCellDelegate?
    
    private var product: Product!
    
    func configureWith(product: Product, delegate: MyProductCellDelegate?) {
                
        self.itemNameLabel.text = product.name
        
        self.itemCategoryLabel.text = product.categoryName
        
        self.itemPriceLabel.text = "£" + product.price!
                
        self.itemImageView.loadImage(urlStringOptional: product.photos?.first?.src)

        self.delegate = delegate
        
        self.product = product
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.removeTopView()
        
        self.configureView()
             
    }
    
    private func configureView() {
        
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
        
        self.delegate?.editButtonPressed(product: self.product)
        
    }
    
}
