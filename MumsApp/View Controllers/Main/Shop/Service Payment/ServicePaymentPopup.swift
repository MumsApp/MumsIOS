import UIKit

class ServicePaymentPopupViewController: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var closeButton: UIButton!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var okButton: UIButton!

    private var inAppPurchaseHelper: InAppPurchaseHelper!

    func configureWith(inAppPurchaseHelper: InAppPurchaseHelper) {
        
        self.inAppPurchaseHelper = inAppPurchaseHelper
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureView()
        
//        NotificationCenter.default.addObserver(self, selector: #selector(self.handleNotification(notification:)), name: InAppPurchaseHelper.PurchaseNotification, object: nil)
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        self.containerView.layer.cornerRadius = 4
        
        self.containerView.backgroundColor = .backgroundWhite
        
    }
    
    private func configureView() {
        
        self.titleLabel.font = .regular(size: 20)
        
    }
    
    @IBAction func closeButtonPressed(_ sender: UIButton) {
        
        self.dismissViewController()
        
    }
    
    @IBAction func okPressed(_ sender: UIButton) {
        
        self.dismissViewController()
        
    }
    
}
