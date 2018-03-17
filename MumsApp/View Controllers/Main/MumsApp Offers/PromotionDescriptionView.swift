import UIKit

protocol PromotionDescriptionViewDelegate: class {
    
    func redeemButtonPressed()
    
}

class PromotionDescriptionView: UIView {
    
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var promotionDescriptionLabel: UILabel!

    @IBOutlet weak var itemTitleLabel: UILabel!

    @IBOutlet weak var itemDescriptionTextView: UITextView!

    @IBOutlet weak var redeemButton: UIButton!
    
    @IBOutlet weak var followButton: UIButton!
    
    @IBOutlet weak var followDescriptionLabel: UILabel!
    
    private weak var delegate: PromotionDescriptionViewDelegate?
    
    func configureView(delegate: PromotionDescriptionViewDelegate) {
        
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
        
        Bundle.main.loadNibNamed("PromotionDescriptionView", owner: self, options: nil)
        
        self.addSubview(self.contentView)
        
        self.contentView.frame = self.bounds
        
        self.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        self.configureView()
        
    }
    
    private func configureView() {
        
        self.contentView.addShadow()
        
        self.backgroundColor = .clear
        
        self.promotionDescriptionLabel.font = .regular(size: 20)

        self.itemTitleLabel.font = .regular(size: 20)
        
        self.itemDescriptionTextView.font = .regular(size: 12)

        self.itemDescriptionTextView.textColor = .mainDarkGrey
        
        self.followDescriptionLabel.font = .regular(size: 13)
        
        self.followDescriptionLabel.textColor = .mainDarkGrey
    
        // Code redeemed
        // Unfollow
        
    }
    
    @IBAction func redeemButtonPressed(_ sender: UIButton) {
    
        self.delegate?.redeemButtonPressed()
    
    }
    
    @IBAction func followButtonPressed(_ sender: UIButton) {
    }
    
    
}

