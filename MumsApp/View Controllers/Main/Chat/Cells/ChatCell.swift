import UIKit

class ChatCell: UITableViewCell, Reusable {

    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var userImageView: LoadableImageView!
    
    @IBOutlet weak var onlineImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var sendImageView: UIImageView!
    @IBOutlet weak var readImageView: UIImageView!
    
    func configureWith(message: LastMessage) {
        
        self.sendImageView.isHidden = true
        
        self.readImageView.isHidden = true

        if let member = message.roomMembers?.first {
            
            self.nameLabel.text = member.displayName
            
        } else {
            
            self.nameLabel.text = "Unknown"
            
        }

        if let lastMessage = message.lastMessage {
            
            self.descriptionLabel.text = lastMessage.msg
            
            self.dateLabel.text = lastMessage.sentDate.niceFormat
            
        }
        
        if let photoURL = message.avatar {
            
            self.userImageView.loadImage(urlStringOptional: photoURL)
            
        }
        
        if let isSent = message.lastMessage?.isSend {
            
            self.sendImageView.isHidden = false
            
        }
        
        if let isRead = message.lastMessage?.isRead {
            
            self.readImageView.isHidden = false

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
