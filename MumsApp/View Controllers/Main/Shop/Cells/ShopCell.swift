import UIKit

class ShopCell: UITableViewCell, Reusable {

    @IBOutlet weak var containerView: UIView!

    @IBOutlet weak var itemImageView: UIImageView!
    
    @IBOutlet weak var watchButton: UIButton!
    
    @IBOutlet weak var itemNameLabel: UILabel!
    
    @IBOutlet weak var itemCategoryLabel: UILabel!
   
    @IBOutlet weak var itemPriceLabel: UILabel!
    
    @IBOutlet weak var itemDistanceLabel: UILabel!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var userImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        self.configureView()
        
    }
    
    private func configureView() {
        
        self.backgroundColor = .clear
        
        self.containerView.addShadow()
        
        self.itemImageView.layer.cornerRadius = 4
        
        self.itemImageView.layer.masksToBounds = true
        
        self.itemNameLabel.font = .regular(size: 20)
        
        self.itemCategoryLabel.font = .regular(size: 13)
        
        self.itemCategoryLabel.textColor = .mainDarkGrey
        
        self.itemPriceLabel.font = .regular(size: 20)

        self.itemDistanceLabel.font = .regular(size: 13)

        self.itemDistanceLabel.textColor = .mainDarkGrey

        self.userNameLabel.font = .regular(size: 13)
        
        self.userNameLabel.textColor = .mainGreen

        self.userImageView.layer.cornerRadius = 15
        
        self.userImageView.layer.masksToBounds = true
        
    }

    @IBAction func watchButtonPressed(_ sender: UIButton) {

        let image = sender.tag == 0 ? #imageLiteral(resourceName: "watchIcon") : #imageLiteral(resourceName: "unwatchIcon")
        
        sender.setImage(image, for: .normal)
        
        sender.tag = sender.tag == 0 ? 1 : 0
        
    }

}
