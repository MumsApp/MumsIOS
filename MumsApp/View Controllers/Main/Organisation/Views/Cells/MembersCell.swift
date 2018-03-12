import UIKit

class MembersCell: UICollectionViewCell, Reusable {
    
    @IBOutlet weak var userImageView: UIImageView!
    
    override func awakeFromNib() {
        
        self.userImageView.layer.cornerRadius = 20
        
        self.userImageView.layer.masksToBounds = true
        
    }
    
}
