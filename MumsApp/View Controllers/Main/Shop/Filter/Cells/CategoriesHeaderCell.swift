import UIKit

class CategoriesHeaderCell: UITableViewCell, Reusable {

    @IBOutlet weak var headerLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    
        self.configureView()
        
    }
    
    private func configureView() {
        
        self.headerLabel.font = .medium(size: 17)
        
        self.headerLabel.textColor = .black
        
        self.backgroundColor = .backgroundWhite

    }
    
}
