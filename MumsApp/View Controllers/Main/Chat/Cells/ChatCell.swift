import UIKit

class ChatCell: UITableViewCell, Reusable {

    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var onlineImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        self.configureView()
        
    }

    private func configureView() {
        
        self.backgroundColor = .clear
        
        self.selectionStyle = .none
        
        self.containerView.addShadow()

        self.userImageView.layer.cornerRadius = 35
        
        self.userImageView.layer.masksToBounds = true
        
        self.nameLabel.font = .regular(size: 20)
        
        self.descriptionLabel.font = .regular(size: 13)
        
        self.descriptionLabel.textColor = .mainDarkGrey
    
        self.dateLabel.font = .regular(size: 14)
        
        self.dateLabel.textColor = .mainDarkGrey
    
    }
    
}
