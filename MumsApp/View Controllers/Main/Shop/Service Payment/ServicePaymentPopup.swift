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
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.handleNotification(notification:)), name: InAppPurchaseHelper.PurchaseNotification, object: nil)

    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        self.containerView.layer.cornerRadius = 4
        
        self.containerView.backgroundColor = .backgroundWhite
        
    }
    
    deinit {
        
        NotificationCenter.default.removeObserver(self)
        
    }
    
    func handleNotification(notification: Notification) {
        
        guard let finished = notification.userInfo?[k_has_finished] as? Bool else { return }
        
        self.progressHUD.dismiss()
        
        if finished {
            
            self.showOkAlertWith(title: "Info", message: "The ad has been added.")
            
        } else {
            
            self.showOkAlertWith(title: "Info", message: "Payment cancelled.")
            
        }
        
    }
    
    private func configureView() {
        
        self.titleLabel.font = .regular(size: 20)
        
    }
    
    @IBAction func closeButtonPressed(_ sender: UIButton) {
        
        self.dismissViewController()
        
    }
    
    @IBAction func okPressed(_ sender: UIButton) {
        
        self.progressHUD.showLoading()
        
        self.inAppPurchaseHelper.requestProducts { products in
            
            guard let product = products?.first else { return }
            
            self.inAppPurchaseHelper.buyProduct(product)
            
        }
        
    }
    
}
