import UIKit

protocol AddCellDelegate: class {
    
    func addButtonPressed()
    
}

class AddCell: UITableViewCell, Reusable {
    
    @IBOutlet weak var containerView: UIView!

    @IBOutlet weak var addButton: UIButton!
    
    private weak var delegate: AddCellDelegate?
    
    override func awakeFromNib() {
        
        self.configureView()
        
    }
    
    func configureWith(buttonTitle: String, delegate: AddCellDelegate?) {
        
        self.addButton.setTitle(buttonTitle, for: .normal)
        
        self.delegate = delegate
        
    }
    
    private func configureView() {
        
        self.backgroundColor = .clear
        
        self.contentView.backgroundColor = .clear
        
        self.containerView.addShadow()
        
        self.addButton.titleLabel?.font = .medium(size: 15)
        
        self.addButton.tintColor = .mainGreen
        
    }
    
    @IBAction func addButtonPressed(_ sender: UIButton) {
    
        self.delegate?.addButtonPressed()
        
    }
    
}
