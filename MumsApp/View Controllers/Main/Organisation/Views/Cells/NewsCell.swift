import UIKit

class NewsCell: UITableViewCell, Reusable {

    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        self.configureView()
        
    }

    func configureView() {
        
        self.backgroundColor = .clear
        
        self.userImageView.layer.cornerRadius = 20
        
        self.userImageView.layer.masksToBounds = true
        
        self.containerView.layer.cornerRadius = 4
        
        self.dateLabel.font = .regular(size: 12)
        
        self.dateLabel.textColor = .mainDarkGrey
        
        self.nameLabel.font = .regular(size: 16)
        
        self.descriptionLabel.font = .regular(size: 12)
        
        self.descriptionLabel.textColor = .mainDarkGrey
        
        self.containerView.addShadow()
        
    }
    
}
