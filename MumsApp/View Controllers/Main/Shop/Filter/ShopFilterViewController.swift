import UIKit
import CoreLocation

protocol ShopFilterViewControllerDelegate: class {
    
    func searchWithFilters(parameters: Dictionary<String, Any>)
    
}

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

    fileprivate var selectedCategoryId: Int? = nil

    private var shopService: ShopService!
    
    private weak var delegate: ShopFilterViewControllerDelegate?
    
    fileprivate var selectedLocation: CLLocationCoordinate2D?
    
    func configureWith(shopService: ShopService, delegate: ShopFilterViewControllerDelegate?) {
        
        self.shopService = shopService
        
        self.delegate = delegate
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.configureView()
        
        self.configureNavigationBar()
        
    }
    
    private func configureView() {
        
        self.view.setBackground()

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
        
        self.searchShopProducts()
        
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
    
    @IBAction func priceSwitchChanged(_ sender: UISwitch) {
    
        if sender.isOn {
            
            self.priceSlider.handleColor = .lineGreyColor
            
            self.priceSlider.colorBetweenHandles = .lineGreyColor
            
            self.priceSlider.setNeedsLayout()
            
            self.priceSlider.layoutIfNeeded()
            
            self.priceSlider.isUserInteractionEnabled = false
            
        } else {
            
            self.priceSlider.handleColor = .mainGreen
            
            self.priceSlider.colorBetweenHandles = .mainGreen
            
            self.priceSlider.setNeedsLayout()
            
            self.priceSlider.layoutIfNeeded()
            
            self.priceSlider.isUserInteractionEnabled = true
            
        }
        
    }
    
    private func showShopCategoriesViewController() {
        
        let factory = SecondaryViewControllerFactory.viewControllerFactory()
        
        let controller = factory.shopCategoriesViewController(delegate: self)
        
        self.navigationController?.pushViewController(controller, animated: true)
        
    }
    
    private func showLocationPopupViewController() {
        
        let factory = SecondaryViewControllerFactory.viewControllerFactory()
        
        let controller = factory.locationPopupViewController(delegate: self, type: .other)
        
        controller.modalPresentationStyle = .overCurrentContext
        
        controller.modalTransitionStyle = .crossDissolve
        
        self.presentViewController(controller)
        
    }
    
    private func searchShopProducts() {

        let lat = self.selectedLocation?.latitude ?? LONDON_LAT
        let long = self.selectedLocation?.longitude ?? LONDON_LONG
        
        var bodyParameters: Dictionary<String, Any> = [k_priceFrom: self.priceSlider.selectedMinValue,
                                                       k_priceTo: self.priceSlider.selectedMaxValue,
                                                       k_userLat: lat,
                                                       k_userLon: long,
                                                       k_distanceFrom: self.distanceSlider.selectedMinValue,
                                                       k_distanceTo: self.distanceSlider.selectedMaxValue]
        
        print(bodyParameters)
        
        if let cat = self.selectedCategoryId {
            
            bodyParameters[k_category] = cat
            
        }
        
        self.delegate?.searchWithFilters(parameters: bodyParameters)
     
        self.navigationController?.popViewController(animated: true)
 
    }
    
}

extension ShopFilterViewController: ShopCategoriesViewControllerDelegate {
    
    func categorySelected(category: ShopSubCategory) {
        
        if let title = category.name {
         
            self.selectCategoryButton.setTitle(title, for: .normal)
            
            self.selectCategoryImageView.image = nil

            self.selectedCategoryId = category.id!
            
        }
        
    }
    
}

extension ShopFilterViewController: RangeSeekSliderDelegate {
    
    func rangeSeekSlider(_ slider: RangeSeekSlider, didChange minValue: CGFloat, maxValue: CGFloat) {
        
        if slider.tag == 0 {
            
            self.minPriceLabel.text = "£" + String(describing: Int(minValue))
            
            self.maxPriceLabel.text = "£" + String(describing: Int(maxValue))

        } else {
            
            let textMin = minValue == 1 ? " mile" : " miles"
            
            let textMax = maxValue == 1 ? " mile" : " miles"
            
            self.minDistanceLabel.text = String(describing: Int(minValue)) + textMin
            
            self.maxDistanceLabel.text = String(describing: Int(maxValue)) + textMax
            
        }
        
    }
    
}

extension ShopFilterViewController: LocationPopupDelegate {
    
    func locationUpdated(coordinate: CLLocationCoordinate2D, locationName: String) {
        
        self.selectedLocation = coordinate
        
    }
    
    func locationNotSelected() {
        
        self.selectedLocation = nil
        
    }
    
}
