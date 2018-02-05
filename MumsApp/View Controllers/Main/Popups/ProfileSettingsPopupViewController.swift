import UIKit

class ProfileSettingsPopupViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
   
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var closeButton: UIButton!
    
    @IBOutlet weak var publicProfileLabel: UILabel!
    
    @IBOutlet weak var publicProfileSwitch: UISwitch!
    
    @IBOutlet weak var pushNotificationsLabel: UILabel!
    
    @IBOutlet weak var pushNotificationsSwitch: UISwitch!
    
    @IBOutlet weak var accessLocationLabel: UILabel!
    
    @IBOutlet weak var accessLocationSwitch: UISwitch!
    
    @IBOutlet weak var emergencyLabel: UILabel!
    
    @IBOutlet weak var emergencySwitch: UISwitch!
    
    @IBOutlet weak var logoutButton: UIButton!
    
    @IBOutlet weak var askQuestionButton: UIButton!
    
    private weak var delegate: LogoutDelegate?
    
    func configureWith(delegate: LogoutDelegate?) {
        
        self.delegate = delegate
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.configureView()
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        self.containerView.layer.cornerRadius = 4
        
        self.containerView.backgroundColor = .containerGreyColor
    
    }
    
    private func configureView() {
        
        self.titleLabel.font = .regular(size: 20)
        
        self.publicProfileLabel.font = .regular(size: 16)
        
        self.pushNotificationsLabel.font = .regular(size: 16)

        self.accessLocationLabel.font = .regular(size: 16)

        self.emergencyLabel.font = .regular(size: 16)

    }
    
    @IBAction func closeButtonPressed(_ sender: UIButton) {
    
        self.dismissViewController()
    
    }
    
    @IBAction func publicProfileSwitchChanged(_ sender: UISwitch) {
    }
    
    @IBAction func pushNotificationsSwitchChanged(_ sender: UISwitch) {
    }
    
    @IBAction func accessLocationSwitchChanged(_ sender: UISwitch) {
    }
    
    @IBAction func emergencySwitchChanged(_ sender: UISwitch) {
    }
    
    @IBAction func logoutButtonPressed(_ sender: UIButton) {
    
        self.delegate?.didLogout()
    
    }
    
    @IBAction func askQuestionButtonPressed(_ sender: UIButton) {
    }
    
}
