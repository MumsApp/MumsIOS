import UIKit

class LobbyFooterCell: UITableViewCell {
    
    @IBOutlet weak var containerView: UIView!

    @IBOutlet weak var addCategoryButton: UIButton!
    
    override func awakeFromNib() {
        
        self.configureView()
        
    }
    
    func configureView() {
        
        self.backgroundColor = .clear
        
        self.contentView.backgroundColor = .clear
        
        self.containerView.addShadow()
        
        self.addCategoryButton.titleLabel?.font = .regular(size: 14)
        
        self.addCategoryButton.tintColor = .mainGreen
        
    }
    
}
