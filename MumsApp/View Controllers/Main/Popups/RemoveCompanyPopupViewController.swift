import UIKit

class RemoveCompanyPopupViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var closeButton: UIButton!
    
    @IBOutlet weak var companyImageView: UIImageView!
    
    @IBOutlet weak var companyNameLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
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
        
        self.companyImageView.layer.cornerRadius = 35
        
        self.companyImageView.layer.masksToBounds = true
        
        self.companyNameLabel.font = .regular(size: 17)
        
        self.companyNameLabel.textColor = .mainGreen
        
        self.descriptionLabel.font = .regular(size: 13)
        
        self.descriptionLabel.textColor = .mainDarkGrey

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
