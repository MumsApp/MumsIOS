import UIKit

protocol LobbyDetailsCellDelegate: class {
    
    func replyButtonPressed(topic: LobbyTopic)
    func userButtonPressed()
    
}

class LobbyDetailsCell: UITableViewCell, Reusable {

    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var userNameButton: UIButton!
   
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var replyButton: UIButton!
  
    private weak var delegate: LobbyDetailsCellDelegate? = nil
    
    var tapGesture: UITapGestureRecognizer!

    private var topic: LobbyTopic!
    
    func configureWith(delegate: LobbyDetailsCellDelegate?, topic: LobbyTopic) {
        
        self.delegate = delegate
        
        self.userNameButton.setTitle(topic.creator?.name, for: .normal)
        
        let timeInterval = TimeInterval(topic.creationDate!)
        
        self.timeLabel.text = Date(timeIntervalSince1970: timeInterval).timeAgoSinceNow()
        
        self.titleLabel.text = topic.title
        
        self.descriptionLabel.text = topic.description
        
        self.topic = topic
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
        self.configureView()
        
    }

    private func configureView() {
        
        self.backgroundColor = .clear
        
        self.containerView.addShadow()
        
        self.selectionStyle = .none
        
        self.userImageView.layer.cornerRadius = 15
        
        self.userImageView.layer.masksToBounds = true

        self.userNameButton.titleLabel?.font = .regular(size: 13)
        
        self.userNameButton.tintColor = .mainGreen
        
        self.timeLabel.font = .regular(size: 13)
        
        self.timeLabel.textColor = .mainDarkGrey
        
        self.titleLabel.font = .regular(size: 20)
        
        self.titleLabel.textColor = .black
        
        self.descriptionLabel.font = .regular(size: 13)
        
        self.descriptionLabel.textColor = .mainDarkGrey
        
        self.replyButton.titleLabel?.font = .regular(size: 14)
        
        self.replyButton.setTitleColor(.mainGreen, for: .normal)
        
        self.tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.imageTapped(sender:)))
        
        self.userImageView.addGestureRecognizer(self.tapGesture)
        
        self.userImageView.isUserInteractionEnabled = true
    }
    
    @IBAction func replyButtonPressed(_ sender: UIButton) {
   
        self.delegate?.replyButtonPressed(topic: self.topic)
        
    }
    
    @IBAction func userButtonPressed(_ sender: UIButton) {
    
        self.delegate?.userButtonPressed()
    
    }
    
    func imageTapped(sender: UITapGestureRecognizer) {
        
        self.delegate?.userButtonPressed()
        
    }
}
