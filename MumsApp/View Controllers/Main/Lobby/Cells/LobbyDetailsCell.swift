import UIKit

protocol LobbyDetailsCellDelegate: class {
    
    func replyButtonPressed()
    
}

class LobbyDetailsCell: UITableViewCell, Reusable {

    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var userNameLabel: UILabel!
   
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var replyButton: UIButton!
  
    private weak var delegate: LobbyDetailsCellDelegate? = nil
    
    func configureWith(delegate: LobbyDetailsCellDelegate?) {
        
        self.delegate = delegate
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
        self.configureView()
        
    }

    private func configureView() {
        
        self.backgroundColor = .clear
        
        self.containerView.addShadow()
        
        self.userImageView.layer.cornerRadius = 15
        
        self.userImageView.layer.masksToBounds = true

        self.userNameLabel.font = .regular(size: 13)
        
        self.userNameLabel.textColor = .mainGreen
        
        self.timeLabel.font = .regular(size: 13)
        
        self.timeLabel.textColor = .mainDarkGrey
        
        self.titleLabel.font = .regular(size: 20)
        
        self.titleLabel.textColor = .black
        
        self.descriptionLabel.font = .regular(size: 13)
        
        self.descriptionLabel.textColor = .mainDarkGrey
        
        self.replyButton.titleLabel?.font = .regular(size: 14)
        
        self.replyButton.setTitleColor(.mainGreen, for: .normal)
        
    }
    
    @IBAction func replyButtonPressed(_ sender: UIButton) {
   
        self.delegate?.replyButtonPressed()
        
    }
    
}
