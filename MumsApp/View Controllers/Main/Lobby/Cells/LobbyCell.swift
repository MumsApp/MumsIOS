import UIKit
import SwipeCellKit

class LobbyCell: SwipeTableViewCell {
    
    @IBOutlet weak var containerView: UIView!

    @IBOutlet weak var lobbyImageView: UIImageView!
    
    @IBOutlet weak var lobbyTitleLabel: UILabel!
    
    @IBOutlet weak var lobbyDescriptionLabel: UILabel!
    
    @IBOutlet weak var lobbyJoinSwitch: UISwitch!
    
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
        
        self.backgroundColor = .clear
                
        self.containerView.addShadow()
        
        self.lobbyTitleLabel.font = .regular(size: 20)
        
        self.lobbyTitleLabel.textColor = .black
        
        self.lobbyDescriptionLabel.font = .regular(size: 13)
    
        self.lobbyDescriptionLabel.textColor = .mainDarkGrey
                
        self.lobbyJoinSwitch.isOn = false
        
    }
    
    @IBAction func lobbySwitchPressed(_ sender: UISwitch) {
    
        
    
    }
    
}
