import UIKit

protocol RemoveContactPopupViewControllerDelegate: class {
    
    func removeConfirmed()
    
}

class RemoveContactPopupViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var closeButton: UIButton!
    
    @IBOutlet weak var userImageView: LoadableImageView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var descriptionSmallLabel: UILabel!
    
    @IBOutlet weak var removeButton: UIButton!
    
    @IBOutlet weak var cancelButton: UIButton!
   
    private weak var delegate: RemoveContactPopupViewControllerDelegate?
    
    private var userDetails: UserDetails?
    
    func configureWith(delegate: RemoveContactPopupViewControllerDelegate?, userDetails: UserDetails?) {
        
        self.delegate = delegate
        
        self.userDetails = userDetails
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.configureView()
        
        self.configureData()
        
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
    
    private func configureData() {
        
        guard let userDetails = self.userDetails else { return }
        
        if let name = userDetails.name, let surname = userDetails.surname {
            
            self.userNameLabel.text = name + " " + surname
            
        }
        
        if let photoURL = userDetails.photo?.src {
            
            self.userImageView.loadImage(urlStringOptional: photoURL)
            
        }
        
    }

    @IBAction func removeButtonPressed(_ sender: UIButton) {
        
        self.delegate?.removeConfirmed()
        
        self.dismissViewController()

    }
   
    @IBAction func closeButtonPressed(_ sender: UIButton) {
        
        self.dismissViewController()
        
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        
        self.dismissViewController()
        
    }
    
}
