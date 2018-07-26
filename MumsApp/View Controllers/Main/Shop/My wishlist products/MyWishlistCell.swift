import UIKit

protocol MyWishlistCellDelegate: class {
    
    func wishlistButtonPressed(product: Product, productImage: UIImage)
    
}

class MyWishlistCell: UICollectionViewCell, Reusable {
    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var itemImageView: UIImageView!
    
    @IBOutlet weak var wishListButton: UIButton!
    
    @IBOutlet weak var itemNameLabel: UILabel!
    
    @IBOutlet weak var itemCategoryLabel: UILabel!
    
    @IBOutlet weak var itemPriceLabel: UILabel!
    
    @IBOutlet weak var itemDistanceLabel: UILabel!
    
    @IBOutlet weak var userNameButton: UIButton!
   
    @IBOutlet weak var userImageView: UIImageView!
    
    private weak var delegate: UserNameDelegate?
    
    private weak var delegateWishlist: MyWishlistCellDelegate?
    
    var tapGesture: UITapGestureRecognizer!
        
    private var product: Product!
    
    func configureWith(delegate: UserNameDelegate?, delegateWishlist: MyWishlistCellDelegate?, product: Product) {
        
        self.delegate = delegate
        
        self.product = product
        
        self.delegateWishlist = delegateWishlist
        
        self.itemNameLabel.text = product.name
        
        self.itemCategoryLabel.text = product.categoryName
        
        self.itemPriceLabel.text = "£" + product.price!
        
        self.itemDistanceLabel.text = "TO DO"
        
        self.userNameButton.setTitle(product.creatorName, for: .normal)
        
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.configureView()
        
        self.removeTopView()
        
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
        
        self.itemDistanceLabel.font = .regular(size: 12)
        
        self.itemDistanceLabel.textColor = .mainDarkGrey

        self.userNameButton.titleLabel?.font = .regular(size: 13)
        
        self.userNameButton.tintColor = .mainGreen

        self.userImageView.layer.cornerRadius = 15
        
        self.userImageView.layer.masksToBounds = true

        self.tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.imageTapped(sender:)))
        
        self.userImageView.addGestureRecognizer(self.tapGesture)
        
        self.userImageView.isUserInteractionEnabled = true
        
    }
    
    @IBAction func wishListButtonPressed(_ sender: UIButton) {
        
        let image = sender.tag == 0 ? #imageLiteral(resourceName: "watchIcon") : #imageLiteral(resourceName: "unwatchIcon")
        
        sender.setImage(image, for: .normal)
        
        sender.tag = sender.tag == 0 ? 1 : 0
        
        self.delegateWishlist?.wishlistButtonPressed(product: self.product, productImage: self.itemImageView.image!)
        
    }
    
    func imageTapped(sender: UITapGestureRecognizer) {
                
        self.delegate?.userNameButtonPressed(userId: String(product.creatorId!))

    }
    
    @IBAction func userNameButtonPressed(_ sender: UIButton) {
    
        self.delegate?.userNameButtonPressed(userId: String(product.creatorId!))

    }
 
}
