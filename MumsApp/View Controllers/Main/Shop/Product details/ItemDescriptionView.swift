import UIKit

class ItemDescriptionView: UIView {
    
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var itemTitleLabel: UILabel!
    
    @IBOutlet weak var itemCategoryLabel: UILabel!

    @IBOutlet weak var itemPriceLabel: UILabel!
    
    @IBOutlet weak var itemDistanceLabel: UILabel!

    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var itemDescriptionTextView: UITextView!
    
    @IBOutlet weak var contactUserButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.commonInit()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.commonInit()
        
    }
    
    private func commonInit() {
        
        Bundle.main.loadNibNamed("ItemDescriptionView", owner: self, options: nil)
        
        self.addSubview(self.contentView)
        
        self.contentView.frame = self.bounds
        
        self.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        self.configureView()
        
    }
    
    private func configureView() {
        
        self.contentView.addShadow()
        
        self.backgroundColor = .clear
        
        self.itemTitleLabel.font = .regular(size: 20)
        
        self.itemCategoryLabel.font = .regular(size: 13)

        self.itemCategoryLabel.textColor = .mainDarkGrey
        
        self.userNameLabel.font = .regular(size: 13)
        
        self.userNameLabel.textColor = .mainGreen
        
        self.itemPriceLabel.font = .regular(size: 20)
        
        self.itemDistanceLabel.font = .regular(size: 13)
        
        self.itemDistanceLabel.textColor = .mainDarkGrey
        
        self.itemDescriptionTextView.font = .regular(size: 12)
        
        self.itemDescriptionTextView.textColor = .mainDarkGrey

        self.userImageView.layer.cornerRadius = 15
        
        self.userImageView.layer.masksToBounds = true
        
    }

}
