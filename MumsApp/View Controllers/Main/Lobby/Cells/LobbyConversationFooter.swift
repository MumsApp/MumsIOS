import UIKit

class LobbyConversationFooter: UITableViewCell, Reusable {
    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var pageLabel: UILabel!
    
    @IBOutlet weak var firstButton: UIButton!
    
    @IBOutlet weak var previousButton: UIButton!
    
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var lastButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.configureView()
        
    }
    
    private func configureView() {
        
        self.backgroundColor = .clear
        
        self.containerView.addShadow()
        
        self.pageLabel.font = .regular(size: 16)
        
    }

    @IBAction func firstButtonPressed(_ sender: UIButton) {
    
        print("First button pressed")
    
    }
    
    @IBAction func previousButtonPressed(_ sender: UIButton) {
    
        print("Previous button pressed")
    
    }
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
    
        print("Next button pressed")
    
    }
    
    @IBAction func lastButtonPressed(_ sender: UIButton) {
    
        print("Last button pressed")
    
    }
    
}
