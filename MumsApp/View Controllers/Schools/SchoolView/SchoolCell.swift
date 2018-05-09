import UIKit

protocol SchoolCellDelegate: class {
    
    func delete()
    
}

class SchoolCell: UITableViewCell, Reusable {

    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var schoolNameLabel: UILabel!
    
    @IBOutlet weak var followLabel: UILabel!
   
    @IBOutlet weak var deleteButton: UIButton!
    
    @IBOutlet weak var followSwitch: UISwitch!
    
    private weak var delegate: SchoolCellDelegate?
    
    func configureWith(delegate: SchoolCellDelegate) {
        
        self.delegate = delegate
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

        self.configureView()
        
    }
    
    func configureView() {
        
        self.selectionStyle = .none
        
        self.backgroundColor = .clear
        
        self.containerView.addShadow()

        self.schoolNameLabel.font = .regular(size: 12)
        
        self.schoolNameLabel.textColor = .mainDarkGrey
        
        self.followLabel.font = .regular(size: 12)
        
        self.followLabel.textColor = .black
        
    }

    @IBAction func deleteButtonPressed(_ sender: UIButton) {
    
        self.delegate?.delete()
    
    }
    
    @IBAction func switchChanged(_ sender: UISwitch) {
    }
    
}

