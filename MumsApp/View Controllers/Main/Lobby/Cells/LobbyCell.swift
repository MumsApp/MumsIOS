import UIKit
import SwipeCellKit

protocol LobbyCellDelegate: class {
    
    func setFavourite(_ on: Bool, lobbyId: String)
    
}

class LobbyCell: SwipeTableViewCell, Reusable {
    
    @IBOutlet weak var containerView: UIView!

    @IBOutlet weak var lobbyImageView: LoadableImageView!
    
    @IBOutlet weak var lobbyTitleLabel: UILabel!
    
    @IBOutlet weak var lobbyDescriptionLabel: UILabel!
    
    @IBOutlet weak var favouriteButton: UIButton!
    
    private weak var lobbyDelegate: LobbyCellDelegate?
    
    var lobbyRoom: LobbyRoom?
    
    func configureWith(lobby: LobbyRoom, lobbyDelegate: LobbyCellDelegate?) {
        
        self.lobbyDelegate = lobbyDelegate
        
        self.lobbyRoom = lobby
        
        self.lobbyTitleLabel.text = lobby.title
        
        self.lobbyDescriptionLabel.text = lobby.description
        
        let favouriteImage = lobby.isFavourite == true ? #imageLiteral(resourceName: "favouriteOn") : #imageLiteral(resourceName: "favouriteOff")
        
        self.favouriteButton.setImage(favouriteImage, for: .normal)
        
        self.favouriteButton.tag = lobby.isFavourite == true ? 1 : 0

        self.lobbyImageView.layer.cornerRadius = 35
        
        self.lobbyImageView.loadImage(urlStringOptional: lobby.img)
    
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
    
        guard let id = self.lobbyRoom?.id else { return }
        
        self.lobbyDelegate?.setFavourite(Bool(sender.tag as NSNumber), lobbyId: String(id))
        
    }
    
}
