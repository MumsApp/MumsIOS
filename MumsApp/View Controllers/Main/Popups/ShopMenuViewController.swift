import UIKit

protocol ShopMenuDelegate: class {
    
    func showSearchViewController()
    func showMyProductsViewController()
    func showMyWishlistViewController()
    
}

class ShopMenuViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var searchButton: UIButton!
    
    @IBOutlet weak var myProductsButton: UIButton!
    
    @IBOutlet weak var myWishlistButton: UIButton!
    
    private weak var delegate: ShopMenuDelegate?
    
    private var type: ShopViewType = .shop
    
    func configureWith(delegate: ShopMenuDelegate?, type: ShopViewType) {
        
        self.delegate = delegate
        
        self.type = type
        
    }
    
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
        
        if self.type == .services {
            
            self.myProductsButton.setTitle("My services", for: .normal)
            
        }
        
        self.titleLabel.font = .regular(size: 20)
        
        self.searchButton.titleLabel?.font = .regular(size: 16)
        
        self.myProductsButton.titleLabel?.font = .regular(size: 16)

        self.myWishlistButton.titleLabel?.font = .regular(size: 16)

    }

    @IBAction func closeButtonPressed(_ sender: UIButton) {

        self.dismissViewController()
    
    }

    @IBAction func searchButtonPressed(_ sender: UIButton) {
    
        self.delegate?.showSearchViewController()
    
    }
    
    @IBAction func myProductsButtonPressed(_ sender: UIButton) {
   
        self.delegate?.showMyProductsViewController()
    
    }
    
    @IBAction func myWishlistButtonPressed(_ sender: UIButton) {
    
        self.delegate?.showMyWishlistViewController()
    
    }
    
}
