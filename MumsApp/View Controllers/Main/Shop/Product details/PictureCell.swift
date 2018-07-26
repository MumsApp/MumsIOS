import UIKit

class PictureCell: UICollectionViewCell, Reusable {
 
    @IBOutlet weak var imageView: LoadableImageView!
    
    func configureWith(url: String?) {
        
        self.imageView.loadImage(urlStringOptional: url)
        
    }
    
}
