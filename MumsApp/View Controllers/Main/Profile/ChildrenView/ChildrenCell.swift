import UIKit

protocol ChildrenCellDelgate: class {
    
    func editButtonPressed()
    
}

class ChildrenCell: UITableViewCell, Reusable {

    @IBOutlet weak var childrenLabel: UILabel!
    
    @IBOutlet weak var editButton: UIButton!
    
    private weak var delegate: ChildrenCellDelgate?
    
    func configureWith(type: String, delegate: ChildrenCellDelgate) {
        
        self.childrenLabel.text = type
        
        self.delegate = delegate
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

        self.configureView()
        
    }
    
    private func configureView() {
        
        self.selectionStyle = .none
        
        self.childrenLabel.font = .regular(size: 12)
        
        self.childrenLabel.textColor = .black
        
        self.editButton.titleLabel?.font = .regular(size: 12)
        
        self.editButton.setTitleColor(.mainGreen, for: .normal)
        
    }

    @IBAction func editButtonPressed(_ sender: UIButton) {
    
        self.delegate?.editButtonPressed()
        
    }
    
}
