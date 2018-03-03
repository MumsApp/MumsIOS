import UIKit

class AddContactCell: UITableViewCell {

    @IBOutlet weak var addButton: UIButton!
    
    private weak var delegate: AddCellDelegate?
    
    func configureWith(delegate: AddCellDelegate?) {
        
        self.delegate = delegate
        
    }
    
    override func awakeFromNib() {
        
        self.configureView()
        
    }
    
    private func configureView() {
        
        self.backgroundColor = .clear
        
        self.contentView.backgroundColor = .clear
        
        self.addButton.titleLabel?.font = .medium(size: 15)
        
        self.addButton.tintColor = .mainGreen
        
    }
    
    @IBAction func addContactButtonPressed(_ sender: UIButton) {
    
        self.delegate?.addButtonPressed()
    
    }
    
}
