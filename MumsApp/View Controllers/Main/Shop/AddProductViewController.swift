import UIKit
import GoogleMaps

class AddProductViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var contentView: UIView!

    @IBOutlet weak var addPhotoButton: UIButton!
    
    @IBOutlet weak var photosView: AddProductImagesView!
    
    @IBOutlet weak var itemLocationView: ItemLocationView!
    
    @IBOutlet weak var descriptionView: AddProductDescriptionView!
    
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!

    private var shopService: ShopService!

    fileprivate let HEIGHT_SMALL: CGFloat = 1050
    fileprivate let HEIGHT_BIG: CGFloat = 1280
    
    fileprivate let imagePicker: UIImagePickerController = UIImagePickerController()
    
    fileprivate var selectedCategoryId: Int?

    fileprivate var selectedLat: String?
    
    fileprivate var selectedLon: String?
    
    func configureWith(shopService: ShopService) {
        
        self.shopService = shopService
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.configureView()
        
        self.configureNavigationBar()

        self.addNotifationsForKeyboard()
        
        self.addGestureRecognizerToContentView()

    }

    deinit {
        
        NotificationCenter.default.removeObserver(self)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
        
    }
    
    private func configureView() {
        
        self.view.setBackground()

        self.imagePicker.delegate = self
        
        self.photosView.isHidden = true
     
        self.heightConstraint.constant = HEIGHT_SMALL

        self.photosView.configureWith(delegate: self, imageCellDelegate: self)
     
        self.descriptionView.configureWith(delegate: self)
        
        self.itemLocationView.configureWith(delegate: self)
    
    }
    
    private func configureNavigationBar() {
        
        let titleLabel = self.navigationController?.configureNavigationBarWithTitle(title: "Add Product")
        
        self.navigationItem.titleView = titleLabel
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        self.navigationItem.hidesBackButton = true
        
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "backButtonIcon"), style: .plain, target: self, action: #selector(self.backButtonPressed(sender:)))
        
        self.navigationItem.leftBarButtonItem = backButton
        
    }
    
    func backButtonPressed(sender: UIBarButtonItem) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
    private func addNotifationsForKeyboard() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasShown(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }
    
    func keyboardWasShown(notification: Notification) {
        
        let userInfo: NSDictionary = notification.userInfo! as NSDictionary
        
        let keyboardInfo = userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue
        
        let keyboardSize = keyboardInfo.cgRectValue.size
        
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        
        self.scrollView.contentInset = contentInsets
        
        self.scrollView.scrollIndicatorInsets = contentInsets
        
    }
    
    func keyboardWasHide(notification: Notification) {
        
        self.scrollView.contentInset = .zero
        
        self.scrollView.scrollIndicatorInsets = .zero
        
    }
    
    private func addGestureRecognizerToContentView() {
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.contentViewPressed(sender:)))
        
        self.contentView.addGestureRecognizer(gesture)
        
    }
    
    func contentViewPressed(sender: UITapGestureRecognizer) {
        
        self.view.endEditing(true)
        
    }
    
    @IBAction func addPhotoButtonPressed(_ sender: UIButton) {
        
        self.showPhotoAlert(imagePicker: self.imagePicker)
        
    }
    
    @IBAction func uploadProductButtonPressed(_ sender: UIButton) {
    
        self.validate()
        
    }
    
    fileprivate func showProductAddedPopupViewController() {
        
        let factory = SecondaryViewControllerFactory.viewControllerFactory()
        
        let controller = factory.productAddedPopupViewController()
        
        controller.modalPresentationStyle = .overCurrentContext
        
        controller.modalTransitionStyle = .crossDissolve
        
        controller.configureWith(delegate: self)
        
        self.presentViewController(controller)
        
    }
    
    fileprivate func showMyProductsViewController() {
        
        let factory = SecondaryViewControllerFactory.viewControllerFactory()
        
        let controller = factory.myProductViewController()
        
        self.navigationController?.pushViewController(controller, animated: true)

    }
    
    private func validate() {

        if self.descriptionView.itemTitleTextField.text == "" {
            
            self.showOkAlertWith(title: "Info", message: "Please enter the product name.")

            return
            
        }
        
        if self.descriptionView.selectCategoryButton.titleLabel?.text == "Add category" {
            
            self.showOkAlertWith(title: "Info", message: "Please select a category.")
            
            return
            
        }
        
        if self.descriptionView.itemPriceTextField.text == "" {
            
            self.showOkAlertWith(title: "Info", message: "Please enter the product price.")
            
            return
            
        }
        
        if self.descriptionView.descriptionTextView.text == "Add description" {
            
            self.showOkAlertWith(title: "Info", message: "Please enter the product description.")
            
            return
            
        }
        
        if self.photosView.images.count == 0 {
            
            self.showOkAlertWith(title: "Info", message: "Please add a product photo.")
            
            return
            
        }
        
        if self.selectedLat == nil || self.selectedLon == nil {
            
            self.showOkAlertWith(title: "Info", message: "Please add your location.")

            return
        
        }
        
        self.addProduct()

    }
    
    private func addProduct() {
        
        guard let token = self.appContext.token() else { return }

        self.shopService.addShopProduct(name: self.descriptionView.itemTitleTextField.text!,
                                        description: self.descriptionView.descriptionTextView.text!,
                                        price: self.descriptionView.itemPriceTextField.text!,
                                        category: String(self.selectedCategoryId!),
                                        token: token,
                                        lat: self.selectedLat!,
                                        lon: self.selectedLon!,
                                        images: self.photosView.images) { errorOptional in
            
            if let error = errorOptional {
                
                print(error.localizedDescription)
                
            } else {
                
                self.showProductAddedPopupViewController()

            }
            
        }
        
    }
    
}

extension AddProductViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        self.dismissViewController()

    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            self.addPhotoButton.setTitle(nil, for: .normal)
            
            self.addPhotoButton.setImage(pickedImage, for: .normal)
            
            self.photosView.images.insert(pickedImage, at: 0)

            self.photosView.collectionView.reloadData()
            
        }
        
        self.photosView.isHidden = false
        
        self.heightConstraint.constant = HEIGHT_BIG
        
        self.dismissViewController()
        
    }
    
}

extension AddProductViewController: AddImageCellDelegate, ImageCellDelegate {
    
    func addPhotoButtonPressed() {
        
        self.showPhotoAlert(imagePicker: self.imagePicker)
        
    }
    
    func deleteImageButtomPressed(tag: Int) {
        
        self.photosView.images.remove(at: tag)
        
        self.photosView.collectionView.reloadData()
        
        if self.photosView.images.count == 0 {
            
            self.addPhotoButton.setTitle("Add photo", for: .normal)
            
            self.addPhotoButton.setImage(#imageLiteral(resourceName: "addPhotoIcon"), for: .normal)
            
            self.photosView.isHidden = true
       
            self.heightConstraint.constant = HEIGHT_SMALL

        } else {
            
            let image = self.photosView.images[tag]
            
            self.addPhotoButton.setImage(image, for: .normal)
            
        }
        
    }
    
    func deselectOtherCells() {
        
//        self.photosView.collectionView.indexPathsForSelectedItems?.forEach({ indexPath in
//            
//            self.photosView.collectionView.deselectItem(at: indexPath, animated: true)
//            
//            let cell = self.photosView.collectionView.cellForItem(at: indexPath) as? ImageCell
//            
//            cell?.layer.borderWidth = 0
//            
//        })
//        
//        let indexPath = IndexPath(row: 1, section: 0)
//        
//        self.photosView.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .bottom)
//        
//        let cell = self.photosView.collectionView.cellForItem(at: indexPath) as? ImageCell
//
//        cell?.layer.borderColor = UIColor.mainGreen.cgColor
//        
//        cell?.layer.borderWidth = 3
        
    }
    
    func selectedImage(tag: Int) {
        
        let image = self.photosView.images[tag]
        
        self.addPhotoButton.setImage(image, for: .normal)
        
    }
    
}

extension AddProductViewController: AddProductDescriptionViewDelegate {
    
    func showShopCategoriesViewController() {
        
        let factory = SecondaryViewControllerFactory.viewControllerFactory()
        
        let controller = factory.shopCategoriesViewController(delegate: self)
        
        self.navigationController?.pushViewController(controller, animated: true)
        
    }

    func showCategoryButtonPressed() {
        
        self.showShopCategoriesViewController()

    }
    
}

extension AddProductViewController: ShopCategoriesViewControllerDelegate {
    
    func categorySelected(category: ShopSubCategory) {
    
        if let title = category.name {
            
            self.descriptionView.selectCategoryButton.setTitle(title, for: .normal)
            
            self.descriptionView.selectCategoryButton.setTitleColor(.black, for: .normal)

        }

        if let id = category.id {
            
            self.selectedCategoryId = id
            
        }
        
    }
    
}

extension AddProductViewController: LocationViewDelegate {
    
    func showSwitchValueChanged(isVisible: Bool) {}
    
    func changeLocationButtonPressed() {
        
        self.showLocationPopupViewController()
        
    }
    
    fileprivate func showLocationPopupViewController() {
        
        let factory = SecondaryViewControllerFactory.viewControllerFactory()
        
        let controller = factory.locationPopupViewController(delegate: self, type: .other)
        
        controller.modalPresentationStyle = .overCurrentContext
        
        controller.modalTransitionStyle = .crossDissolve
        
        self.presentViewController(controller)
        
    }
    
}

extension AddProductViewController: LocationPopupDelegate {
    
    func locationUpdated(coordinate: CLLocationCoordinate2D, locationName: String) {
        
        self.itemLocationView.mapView.clear()
        
        self.itemLocationView.mapView.addMarker(lat: coordinate.latitude, lon: coordinate.longitude)
        
        let cameraUpdate = GMSCameraUpdate.setTarget(coordinate, zoom: 12)
        
        self.itemLocationView.mapView.animate(with: cameraUpdate)
        
        self.itemLocationView.userLocationLabel.text = locationName
        
        self.selectedLat = String(coordinate.latitude)
        
        self.selectedLon = String(coordinate.longitude)
        
    }
    
    func locationNotSelected() {
        
        
    }
    
}

extension AddProductViewController: ProductAddedPopupDelegate {
    
    func backToMyProductButtonPressed() {
        
        self.showMyProductsViewController()
        
    }
    
    func backToSearchButtonPressed() {

        self.popToViewController(ShopViewController.self)
        
    }

}
