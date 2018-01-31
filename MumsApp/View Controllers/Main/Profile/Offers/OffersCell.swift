import UIKit

class OffersCell: UITableViewCell {

    @IBOutlet weak var offersTitleLabel: UILabel!
    
    @IBOutlet weak var offersSwitch: UISwitch!
    
    func configureWith(title: String) {
        
        self.offersTitleLabel.text = title
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

        self.configureView()
    
    }

    private func configureView() {
        
        self.offersTitleLabel.font = .regular(size: 12)
        
        self.offersTitleLabel.textColor = .mainDarkGrey

    }
    
    @IBAction func offersSwitchPressed(_ sender: UISwitch) {
    
        
    
    }
    
}
