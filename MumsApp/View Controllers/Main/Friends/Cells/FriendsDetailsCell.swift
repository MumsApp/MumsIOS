import UIKit

class FriendsDetailsCell: UITableViewCell, Reusable {
    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var userImageView: LoadableImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    func configureWith(friend: Friend) {
        
        if let name = friend.name, let surname = friend.surname {
            
            self.nameLabel.text = name + " " + surname
            
        } else {
            
            self.nameLabel.text = "Unknown"
            
        }
        
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
        
    }
    
}
