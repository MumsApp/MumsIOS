import UIKit

protocol ServicePaymentPopupViewControllerDelegate: class {
    
    func paid()
    
}

class ServicePaymentPopupViewController: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var closeButton: UIButton!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var okButton: UIButton!

    private var inAppPurchaseHelper: InAppPurchaseHelper!

    private weak var delegate: ServicePaymentPopupViewControllerDelegate?
    
    func configureWith(inAppPurchaseHelper: InAppPurchaseHelper, delegate: ServicePaymentPopupViewControllerDelegate?) {
        
        self.inAppPurchaseHelper = inAppPurchaseHelper
        
        self.delegate = delegate
        
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
            
            self.delegate?.paid()

            self.dismissViewController()
            
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
