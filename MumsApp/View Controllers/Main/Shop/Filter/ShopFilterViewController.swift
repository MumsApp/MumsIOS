import UIKit

class ShopFilterViewController: UIViewController {

    @IBOutlet weak var categoryContainer: UIView!
    
    @IBOutlet weak var priceContainer: UIView!
    
    @IBOutlet weak var distanceContainer: UIView!
    
    @IBOutlet weak var productTypeTitleLabel: UILabel!
    
    @IBOutlet weak var selectCategoryButton: UIButton!
    
    @IBOutlet weak var selectCategoryImageView: UIImageView!
    
    @IBOutlet weak var priceRangeTitleLabel: UILabel!
    
    @IBOutlet weak var freeLabel: UILabel!
    
    @IBOutlet weak var priceRangeLabel: UILabel!
    
    @IBOutlet weak var minPriceLabel: UILabel!
    
    @IBOutlet weak var maxPriceLabel: UILabel!
    
    @IBOutlet weak var priceSlider: RangeSeekSlider!
    
    @IBOutlet weak var distanceTitleLabel: UILabel!
    
    @IBOutlet weak var distanceLabel: UILabel!
    
    @IBOutlet weak var minDistanceLabel: UILabel!
    
    @IBOutlet weak var maxDistanceLabel: UILabel!
    
    @IBOutlet weak var distanceSlider: RangeSeekSlider!
    
    @IBOutlet weak var setLocationButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.configureView()
        
        self.configureNavigationBar()
        
    }
    
    private func configureView() {
        
        self.productTypeTitleLabel.font = .semiBold(size: 15)
        
        self.priceRangeTitleLabel.font = .semiBold(size: 15)

        self.distanceTitleLabel.font = .semiBold(size: 15)

        self.categoryContainer.addShadow()
        
        self.priceContainer.addShadow()
        
        self.distanceContainer.addShadow()
        
        self.selectCategoryButton.titleLabel?.font = .regular(size: 12)
        
        self.selectCategoryButton.setTitleColor(.mainDarkGrey, for: .normal)
        
        self.freeLabel.font = .regular(size: 12)
        
        self.freeLabel.textColor = .mainDarkGrey
        
        self.priceRangeLabel.font = .regular(size: 12)
        
        self.priceRangeLabel.textColor = .mainDarkGrey
        
        self.minPriceLabel.font = .regular(size: 12)
        
        self.minPriceLabel.textColor = .mainDarkGrey
        
        self.maxPriceLabel.font = .regular(size: 12)
        
        self.maxPriceLabel.textColor = .mainDarkGrey
        
        self.distanceLabel.font = .regular(size: 12)
        
        self.distanceLabel.textColor = .mainDarkGrey
        
        self.minDistanceLabel.font = .regular(size: 12)
        
        self.minDistanceLabel.textColor = .mainDarkGrey
        
        self.maxDistanceLabel.font = .regular(size: 12)
        
        self.maxDistanceLabel.textColor = .mainDarkGrey
     
        self.setLocationButton.setTitleColor(.mainGreen, for: .normal)
        
        self.setLocationButton.titleLabel?.font = .regular(size: 14)
        
        self.priceSlider.delegate = self
    
        self.priceSlider.tag = 0
    
        self.distanceSlider.delegate = self
        
        self.distanceSlider.tag = 1
    
    }

    private func configureNavigationBar() {
        
        let titleLabel = self.navigationController?.configureNavigationBarWithTitle(title: "Filter")
        
        self.navigationItem.titleView = titleLabel
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        self.navigationItem.hidesBackButton = true
        
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "backButtonIcon"), style: .plain, target: self, action: #selector(self.backButtonPressed(sender:)))
        
        self.navigationItem.leftBarButtonItem = backButton
        
        let rightButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.doneButtonPressed(sender:)))
        
        rightButton.tintColor = .mainGreen
        
        self.navigationItem.rightBarButtonItem = rightButton
    
    }
    
    func doneButtonPressed(sender: UIBarButtonItem) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
    func backButtonPressed(sender: UIBarButtonItem) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func selectCategoryButtonPressed(_ sender: UIButton) {
    
        self.showShopCategoriesViewController()
        
    }
    
    @IBAction func setLocationButtonPressed(_ sender: UIButton) {
    
        self.showLocationPopupViewController()
    
    }
    
    private func showShopCategoriesViewController() {
        
        let factory = SecondaryViewControllerFactory.viewControllerFactory()
        
        let controller = factory.shopCategoriesViewController(delegate: self)
        
        self.navigationController?.pushViewController(controller, animated: true)
        
    }
    
    private func showLocationPopupViewController() {
        
        let factory = SecondaryViewControllerFactory.viewControllerFactory()
        
        let controller = factory.locationPopupViewController(delegate: nil)
        
        controller.modalPresentationStyle = .overCurrentContext
        
        controller.modalTransitionStyle = .crossDissolve
        
        self.presentViewController(controller)
        
    }
    
}

extension ShopFilterViewController: ShopCategoriesViewControllerDelegate {
    
    func categorySelected(title: String) {
        
        self.selectCategoryButton.setTitle(title, for: .normal)
        
        self.selectCategoryImageView.image = nil
        
    }
    
}

extension ShopFilterViewController: RangeSeekSliderDelegate {
    
    func rangeSeekSlider(_ slider: RangeSeekSlider, didChange minValue: CGFloat, maxValue: CGFloat) {
        
        if slider.tag == 0 {
            
            self.minPriceLabel.text = "£" + String(describing: Int(minValue))
            
            self.maxPriceLabel.text = "£" + String(describing: Int(maxValue))

        } else {
            
            let textMin = minValue > 1 ? " miles" : " mile"
            
            let textMax = maxValue > 1 ? " miles" : " mile"

            self.minDistanceLabel.text = String(describing: Int(minValue)) + textMin
            
            self.maxDistanceLabel.text = String(describing: Int(maxValue)) + textMax
            
        }
        
    }
    
}
