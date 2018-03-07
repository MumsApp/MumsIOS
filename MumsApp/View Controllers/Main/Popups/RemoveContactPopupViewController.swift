import UIKit

class RemoveContactPopupViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var closeButton: UIButton!
    
    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var descriptionSmallLabel: UILabel!
    
    @IBOutlet weak var removeButton: UIButton!
    
    @IBOutlet weak var cancelButton: UIButton!
   
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
        
        self.userImageView.layer.cornerRadius = 35
        
        self.userImageView.layer.masksToBounds = true
        
        self.userNameLabel.font = .regular(size: 17)
        
        self.userNameLabel.textColor = .mainGreen
        
        self.descriptionLabel.font = .regular(size: 20)
        
        self.descriptionSmallLabel.font = .regular(size: 13)
        
        self.descriptionSmallLabel.textColor = .mainDarkGrey
        
        self.cancelButton.tintColor = .mainDarkGrey
        
        self.cancelButton.titleLabel?.font = .medium(size: 15)
        
    }

    @IBAction func removeButtonPressed(_ sender: UIButton) {
        
        // TODO: - remove
        
        self.dismissViewController()
        
    }
   
    @IBAction func closeButtonPressed(_ sender: UIButton) {
        
        self.dismissViewController()
        
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        
        self.dismissViewController()
        
    }
    
}
