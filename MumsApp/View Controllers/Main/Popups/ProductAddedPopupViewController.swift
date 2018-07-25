import UIKit

protocol ProductAddedPopupDelegate: class {
    
    func backToSearchButtonPressed()
    func backToMyProductButtonPressed()
    
}

class ProductAddedPopupViewController: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var closeButton: UIButton!
    
    @IBOutlet weak var itemImageView: UIImageView!
    
    @IBOutlet weak var backToSearchButton: UIButton!
    
    @IBOutlet weak var backToMyProductList: UIButton!
    
    private weak var delegate: ProductAddedPopupDelegate?
    
    func configureWith(delegate: ProductAddedPopupDelegate) {
        
        self.delegate = delegate
        
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
        
        self.titleLabel.font = .regular(size: 20)
        
        self.itemImageView.layer.cornerRadius = 35
        
        self.itemImageView.layer.masksToBounds = true
       
        self.backToMyProductList.tintColor = .mainDarkGrey
        
        self.backToMyProductList.titleLabel?.font = .medium(size: 15)
        
    }
    
    @IBAction func backToSearchButtonPressed(_ sender: UIButton) {
        
        self.delegate?.backToSearchButtonPressed()
        
        self.dismissViewController()

    }
    
    @IBAction func closeButtonPressed(_ sender: UIButton) {
        
        self.dismissViewController()
        
    }
    
    @IBAction func backToMyProductButtonPressed(_ sender: UIButton) {
        
        self.delegate?.backToMyProductButtonPressed()
    
        self.dismissViewController()
        
    }
    
}

