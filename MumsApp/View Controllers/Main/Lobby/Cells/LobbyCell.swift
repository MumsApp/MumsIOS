import UIKit
import SwipeCellKit

class LobbyCell: SwipeTableViewCell, Reusable {
    
    @IBOutlet weak var containerView: UIView!

    @IBOutlet weak var lobbyImageView: UIImageView!
    
    @IBOutlet weak var lobbyTitleLabel: UILabel!
    
    @IBOutlet weak var lobbyDescriptionLabel: UILabel!
    
    @IBOutlet weak var favouriteButton: UIButton!
    
    func configureWith(lobby: Lobby) {
        
        self.lobbyTitleLabel.text = lobby.title
        
        self.lobbyDescriptionLabel.text = lobby.description
        
        self.lobbyImageView.image = lobby.image
        
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
        
    }
    
    @IBAction func favouriteButtonPressed(_ sender: UIButton) {
    
        let image = sender.tag == 0 ? #imageLiteral(resourceName: "favouriteOn") : #imageLiteral(resourceName: "favouriteOff")
        
        sender.setImage(image, for: .normal)
        
        sender.tag = sender.tag == 0 ? 1 : 0
    
    }
    
}
