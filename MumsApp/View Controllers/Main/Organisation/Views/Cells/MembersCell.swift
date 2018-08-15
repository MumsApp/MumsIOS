import UIKit

class MembersCell: UICollectionViewCell, Reusable {
    
    @IBOutlet weak var userImageView: LoadableImageView!
    
    func configureWith(friend: Friend) {
        
        self.userImageView.loadImage(urlStringOptional: friend.photo)
        
    }
    
    override func awakeFromNib() {
        
        self.userImageView.layer.cornerRadius = 20
        
        self.userImageView.layer.masksToBounds = true
        
    }
    
}
