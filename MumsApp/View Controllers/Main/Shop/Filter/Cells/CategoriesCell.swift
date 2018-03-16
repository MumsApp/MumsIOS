import UIKit

class CategoriesCell: UITableViewCell, Reusable {

    @IBOutlet weak var categoryLabel: UILabel!
   
    override func awakeFromNib() {
        super.awakeFromNib()
    
        self.configureView()
        
    }
    
    private func configureView() {
        
        self.categoryLabel.font = .regular(size: 15)
        
        self.categoryLabel.textColor = .black
        
    }

}
