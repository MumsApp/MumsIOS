import UIKit

protocol RemoveProductPopupViewControllerDelegate: class {
    
    func productRemoved()
    
}

class RemoveProductPopupViewController: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var closeButton: UIButton!
    
    @IBOutlet weak var itemImageView: UIImageView!
    
    @IBOutlet weak var itemNameLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var removeButton: UIButton!
    
    private var shopService: ShopService!
    
    private var delegate: RemoveProductPopupViewControllerDelegate?
    
    private var product: Product!
    
    private var productImage: UIImage!
    
    func configureWith(product: Product, productImage: UIImage, shopService: ShopService, delegate: RemoveProductPopupViewControllerDelegate?) {
        
        self.product = product
        
        self.productImage = productImage
        
        self.shopService = shopService
        
        self.delegate = delegate
        
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
        
        self.itemImageView.layer.cornerRadius = 35
        
        self.itemImageView.layer.masksToBounds = true
        
        self.itemNameLabel.font = .regular(size: 17)
        
        self.itemNameLabel.textColor = .mainGreen
        
        self.descriptionLabel.font = .regular(size: 20)
        
    }
    
    func configureData() {
        
        self.itemNameLabel.text = self.product.name
        
        self.itemImageView.image = self.productImage
        
    }
    
    @IBAction func removeButtonPressed(_ sender: UIButton) {
        
        self.removeFavouriteProduct(id: String(self.product.id!))
        
    }
    
    @IBAction func closeButtonPressed(_ sender: UIButton) {
        
        self.dismissViewController()
        
    }
    
    func removeFavouriteProduct(id: String) {
        
        guard let token = self.appContext.token() else { return }
        
        self.shopService.removeFavouriteProduct(id: id, token: token) { errorOptional in
            
            if let error = errorOptional {
                
                self.showOkAlertWith(title: "Error", message: error.localizedDescription)
                
            } else {
                
                self.dismissViewController()

                self.delegate?.productRemoved()
           
            }
            
        }
        
    }
    
}
