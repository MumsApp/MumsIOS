import UIKit

class ChatSettingsCell: UITableViewCell {

    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var enableButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        self.configureView()
        
    }

    private func configureView() {
        
        self.userImageView.layer.cornerRadius = 20
        
        self.userImageView.layer.masksToBounds = true
        
        self.userNameLabel.font = .regular(size: 16)
        
        self.userNameLabel.text = "Unknown"
        
        self.enableButton.setImage(#imageLiteral(resourceName: "onIcon"), for: .normal)
        
    }
    
    func configureForHeader() {
        
        self.userNameLabel.font = .semiBold(size: 16)
        
        self.userNameLabel.text = "Select all"
        
        self.enableButton.setImage(#imageLiteral(resourceName: "offIcon"), for: .normal)

        
    }
    
    @IBAction func enableButtonPressed(_ sender: UIButton) {
        
        let image = sender.tag == 0 ? #imageLiteral(resourceName: "onIcon") : #imageLiteral(resourceName: "offIcon")
        
        sender.setImage(image, for: .normal)
        
        sender.tag = sender.tag == 0 ? 1 : 0
        
    }

}
