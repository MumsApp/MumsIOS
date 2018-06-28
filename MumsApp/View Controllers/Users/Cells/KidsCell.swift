import UIKit

class KidsCell: UITableViewCell {

    @IBOutlet weak var kidsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        self.kidsLabel.font = .regular(size: 15)
        
    }

}
