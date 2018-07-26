import UIKit

protocol LobbyConversationCellDelegate: class {
    
    func userButtonPressed(userId: String)
    
}

class LobbyConversationCell: UITableViewCell, Reusable {
    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var userImageView: LoadableImageView!
    
    @IBOutlet weak var userNameButton: UIButton!
    
    @IBOutlet weak var timeLabel: UILabel!
        
    @IBOutlet weak var descriptionLabel: UILabel!
    
    private weak var delegate: LobbyConversationCellDelegate? = nil
    
    var tapGesture: UITapGestureRecognizer!
    
    var post: LobbyPost!
    
    func configureWith(delegate: LobbyConversationCellDelegate?, lobbyPost: LobbyPost) {
        
        self.delegate = delegate
        
        self.userNameButton.setTitle(lobbyPost.author?.name, for: .normal)

        let timeInterval = TimeInterval(lobbyPost.creationDate!)
        
        self.timeLabel.text = Date(timeIntervalSince1970: timeInterval).timeAgoSinceNow()
        
        self.descriptionLabel.text = lobbyPost.description

        self.post = lobbyPost
    
        self.userImageView.loadImage(urlStringOptional: lobbyPost.author?.img)
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.configureView()
        
    }
    
    private func configureView() {
        
        self.backgroundColor = .clear
                
        self.userImageView.layer.cornerRadius = 15
        
        self.userImageView.layer.masksToBounds = true
        
        self.userNameButton.titleLabel?.font = .regular(size: 13)
        
        self.userNameButton.tintColor = .mainGreen
        
        self.timeLabel.font = .regular(size: 13)
        
        self.timeLabel.textColor = .mainDarkGrey
        
        self.descriptionLabel.font = .regular(size: 13)
        
        self.descriptionLabel.textColor = .mainDarkGrey
        
        self.tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.imageTapped(sender:)))
        
        self.userImageView.addGestureRecognizer(self.tapGesture)
        
        self.userImageView.isUserInteractionEnabled = true
    
    }
    
    @IBAction func userButtonPressed(_ sender: UIButton) {
        
        guard let id = self.post.author?.id else { return }
        
        self.delegate?.userButtonPressed(userId: String(id))
        
    }
    
    func imageTapped(sender: UITapGestureRecognizer) {
        
        guard let id = self.post.author?.id else { return }

        self.delegate?.userButtonPressed(userId: String(id))

    }
    
}
