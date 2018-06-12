import UIKit

protocol AddToMenuCellDelegate: class {
    
    func addToMenu()
    
}

class AddToMenuCell: UITableViewCell, Reusable {
    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var lobbyImageView: UIImageView!
    
    @IBOutlet weak var lobbyTitleLabel: UILabel!
    
    @IBOutlet weak var lobbyDescriptionLabel: UILabel!
    
    @IBOutlet weak var addToMenuButton: UIButton!
    
    private weak var delegate: AddToMenuCellDelegate?
    
    func configureWith(lobby: Lobby, delegate: AddToMenuCellDelegate?) {
        
        self.lobbyTitleLabel.text = lobby.title
        
        self.lobbyDescriptionLabel.text = lobby.description
        
        self.lobbyImageView.image = lobby.image
        
        self.delegate = delegate
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.configureView()
        
    }
    
    private func configureView() {
        
        self.selectionStyle = .none
        
        self.backgroundColor = .clear
        
        self.containerView.addShadow()
        
        self.lobbyTitleLabel.font = .regular(size: 20)
        
        self.lobbyTitleLabel.textColor = .black
        
        self.lobbyDescriptionLabel.font = .regular(size: 13)
        
        self.lobbyDescriptionLabel.textColor = .mainDarkGrey
        
        self.lobbyDescriptionLabel.numberOfLines = 0
     
        self.addToMenuButton.setTitleColor(.mainGreen, for: .normal)
        
        self.addToMenuButton.titleLabel?.font = .regular(size: 12)
        
    }
    
    @IBAction func addToMenuButtonPressed(_ sender: UIButton) {
    
        self.delegate?.addToMenu()
    
    }
    
}
