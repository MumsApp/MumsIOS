import UIKit

protocol LobbyConversationFooterDelegate: class {
    
    func firstButtonPressed()
    func previousButtonPressed()
    func nextButtonPressed()
    func lastButtonPressed()
    
}

class LobbyConversationFooter: UITableViewCell, Reusable {
    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var pageLabel: UILabel!
    
    @IBOutlet weak var firstButton: UIButton!
    
    @IBOutlet weak var previousButton: UIButton!
    
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var lastButton: UIButton!
    
    private weak var delegate: LobbyConversationFooterDelegate?
    
    func configureWith(delegate: LobbyConversationFooterDelegate?) {
        
        self.delegate = delegate
        
    }
    
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
    
        self.delegate?.firstButtonPressed()
    
    }
    
    @IBAction func previousButtonPressed(_ sender: UIButton) {
    
        self.delegate?.previousButtonPressed()
    
    }
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
    
        self.delegate?.nextButtonPressed()
    
    }
    
    @IBAction func lastButtonPressed(_ sender: UIButton) {
    
        self.delegate?.lastButtonPressed()
    
    }
    
}
