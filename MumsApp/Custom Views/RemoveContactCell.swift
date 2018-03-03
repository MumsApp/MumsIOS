import UIKit

protocol RemoveContactCellDelegate: class {
    
    func removeButtonPressed()
    
}

class RemoveContactCell: UITableViewCell {
    
    @IBOutlet weak var removeButton: UIButton!
    
    private weak var delegate: RemoveContactCellDelegate?
    
    func configureWith(delegate: RemoveContactCellDelegate?) {
        
        self.delegate = delegate
        
    }
    
    override func awakeFromNib() {
    
        self.configureView()
        
    }
    
    private func configureView() {
        
        self.backgroundColor = .clear
        
        self.contentView.backgroundColor = .clear
        
        self.removeButton.titleLabel?.font = .medium(size: 15)
        
        self.removeButton.tintColor = .mainDarkGrey
        
    }
    
    @IBAction func removeButtonPressed(_ sender: UIButton) {

        self.delegate?.removeButtonPressed()
    
    }

}
