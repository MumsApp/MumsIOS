import UIKit
import MessageUI

class ProfileSettingsPopupViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
   
    @IBOutlet weak var containerBottomView: UIView!
    
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
    
    private weak var rootViewController: UIViewController?
    
    func configureWith(delegate: LogoutDelegate?, rootViewController: UIViewController?) {
        
        self.delegate = delegate
        
        self.rootViewController = rootViewController
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.configureView()
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        self.containerView.layer.cornerRadius = 4
        
        self.containerView.backgroundColor = .white

        self.containerBottomView.backgroundColor = .containerGreyColor
        
        self.containerBottomView.roundCorners(corners: [.bottomRight, .bottomLeft], withRadius: 4)
    
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
        
        if let rootViewController = self.rootViewController as? MainRootViewController {
            
            rootViewController.removeMenuButton()
            
            self.delegate?.didLogout()

            self.dismissViewController()
            
        }
        
    }
    
    @IBAction func askQuestionButtonPressed(_ sender: UIButton) {
    
        if !MFMailComposeViewController.canSendMail() { return }
    
        let composeVC = MFMailComposeViewController()
        composeVC.mailComposeDelegate = self
        
        composeVC.setToRecipients(["support@mumsapp.com"])
        composeVC.setSubject("Subject")
        composeVC.setMessageBody("Message", isHTML: false)
        
        self.present(composeVC, animated: true, completion: nil)
        
    }
    
}

extension ProfileSettingsPopupViewController: MFMailComposeViewControllerDelegate {
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
 
        controller.dismiss(animated: true, completion: nil)
    
    }
    
}
