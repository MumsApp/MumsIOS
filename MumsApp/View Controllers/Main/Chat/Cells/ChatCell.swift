import UIKit

class ChatCell: UITableViewCell, Reusable {

    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var userImageView: LoadableImageView!
    
    @IBOutlet weak var onlineImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    func configureWith(friend: Friend) {
        
        if let name = friend.name, let surname = friend.surname {
         
            self.nameLabel.text = name + " " + surname

        } else {
            
            self.nameLabel.text = "Unknown"
            
        }
        
        self.descriptionLabel.text = friend.description
        
        if let photoURL = friend.photo {
            
            self.userImageView.loadImage(urlStringOptional: photoURL)
            
        }
        
    }
    
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
