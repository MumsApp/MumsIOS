import UIKit

class RemoveProductPopupViewController: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var closeButton: UIButton!
    
    @IBOutlet weak var itemImageView: UIImageView!
    
    @IBOutlet weak var itemNameLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var removeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureView()
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        self.containerView.layer.cornerRadius = 4
        
        self.containerView.backgroundColor = .white
        
    }
    
    private func configureView() {
        
        self.titleLabel.font = .regular(size: 20)
        
        self.itemImageView.layer.cornerRadius = 35
        
        self.itemImageView.layer.masksToBounds = true
        
        self.itemNameLabel.font = .regular(size: 17)
        
        self.itemNameLabel.textColor = .mainGreen
        
        self.descriptionLabel.font = .regular(size: 20)
        
    }
    
    @IBAction func removeButtonPressed(_ sender: UIButton) {
        
        // TODO: - remove
        
        self.dismissViewController()
        
    }
    
    @IBAction func closeButtonPressed(_ sender: UIButton) {
        
        self.dismissViewController()
        
    }
    
}
