import UIKit

protocol ImageCellDelegate: class {
    
    func deleteImageButtomPressed(tag: Int)
    func deselectOtherCells()
    func selectedImage(tag: Int)
    
}

class ImageCell: UICollectionViewCell, Reusable {
    
    @IBOutlet weak var itemButton: UIButton!
    
    @IBOutlet weak var deleteButton: UIButton!
    
    private weak var delegate: ImageCellDelegate?
    
    func configureWith(delegate: ImageCellDelegate?, tag: Int) {
        
        self.delegate = delegate
        
        self.tag = tag
        
    }
    
    override func awakeFromNib() {
    
        self.layer.cornerRadius = 4
        
        self.layer.masksToBounds = true
        
        self.removeTopView()
        
    }
    
    @IBAction func itemButtonPressed(_ sender: UIButton) {
        
        self.delegate?.selectedImage(tag: self.tag)
        
    }
    
    @IBAction func deleteButtonPressed(_ sender: UIButton) {
    
        self.delegate?.deleteImageButtomPressed(tag: self.tag)
        
    }
    
}
