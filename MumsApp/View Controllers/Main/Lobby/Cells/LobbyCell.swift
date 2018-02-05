import UIKit
import SwipeCellKit

class LobbyCell: SwipeTableViewCell {
    
    @IBOutlet weak var containerView: UIView!

    @IBOutlet weak var lobbyImageView: UIImageView!
    
    @IBOutlet weak var lobbyTitleLabel: UILabel!
    
    @IBOutlet weak var lobbyDescriptionLabel: UILabel!
    
    @IBOutlet weak var lobbyJoinSwitch: UISwitch!
    
    func configureWith(title: String, description: String) {
        
        self.lobbyTitleLabel.text = title
        
        self.lobbyDescriptionLabel.text = description
        
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
