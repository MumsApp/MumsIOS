import UIKit

protocol ShopFilterCellDelegate: class {
    
    func filterButtonPressed()
    
}

class ShopFilterCell: UITableViewCell, Reusable {
    
    @IBOutlet weak var categoryLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var distanceLabel: UILabel!
    
    private weak var delegate: ShopFilterCellDelegate?
    
    func configureWith(delegate: ShopFilterCellDelegate?) {
        
        self.delegate = delegate
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.configureView()
        
    }
    
    private func configureView() {
        
        self.selectionStyle = .none
        
        self.backgroundColor = .clear
  
        self.categoryLabel.font = .regular(size: 13)
        
        self.priceLabel.font = .regular(size: 13)
        
        self.distanceLabel.font = .regular(size: 13)
     
    }
    
    @IBAction func filterButtonPressed(_ sender: UIButton) {
        
        self.delegate?.filterButtonPressed()
        
    }
    
}
