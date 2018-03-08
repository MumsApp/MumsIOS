import UIKit

protocol AddImageCellDelegate: class {
    
    func addPhotoButtonPressed()
    
}

class AddImageCell: UICollectionViewCell, Reusable {
 
    @IBOutlet weak var addPhotoButton: UIButton!
    
    private weak var delegate: AddImageCellDelegate?
    
    func configureWith(delegate: AddImageCellDelegate?) {
        
        self.delegate = delegate
        
    }
    
    override func awakeFromNib() {
        
        self.layer.cornerRadius = 4
        
        self.layer.masksToBounds = true
    
        self.addPhotoButton.titleLabel?.font = .regular(size: 17)
        
        self.addPhotoButton.setTitleColor(.mainGreen, for: .normal)
        
        self.removeTopView()
        
    }
    
    @IBAction func addPhotoButtonPressed(_ sender: UIButton) {

        self.delegate?.addPhotoButtonPressed()
        
    }

}
