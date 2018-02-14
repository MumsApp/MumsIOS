import UIKit

class LobbyFooterCell: UITableViewCell, Reusable {
    
    @IBOutlet weak var containerView: UIView!

    @IBOutlet weak var addCategoryButton: UIButton!
    
    override func awakeFromNib() {
        
        self.configureView()
        
    }
    
    func configureView() {
        
        self.backgroundColor = .clear
        
        self.contentView.backgroundColor = .clear
        
        self.containerView.addShadow()
        
        self.addCategoryButton.titleLabel?.font = .medium(size: 15)
        
        self.addCategoryButton.tintColor = .mainGreen
        
    }
    
}
