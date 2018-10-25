import UIKit
import GoogleMaps

class AddProductViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var contentView: UIView!

    @IBOutlet weak var addPhotoButton: UIButton!
    
    @IBOutlet weak var uploadProductButton: UIButton!
    
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
    
    private var productOptional: Product?
    
    private var imageLoader: ImageCacheLoader!
    
    fileprivate var type: ShopViewType = .shop

    func configureWith(shopService: ShopService, imageLoader: ImageCacheLoader, productOptional: Product?, type: ShopViewType) {
        
        self.type = type
        
        self.shopService = shopService
        
        self.productOptional = productOptional
        
        self.imageLoader = imageLoader
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.configureView()
        
        self.configureNavigationBar()

        self.addNotifationsForKeyboard()
        
        self.addGestureRecognizerToContentView()

        self.configureData()
        
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
    
        self.descriptionView.itemPriceTextField.delegate = self
        
    }
    
    private func configureNavigationBar() {
       
        var typeText: String!
        
        if self.type == .shop {
            
            typeText = "Product"
            
        } else {
            
            typeText = "Service"
            
        }
                
        let title = productOptional == nil ? "Add \(String(describing: typeText))" : "Edit \(String(describing: typeText))"
        
        let titleLabel = self.navigationController?.configureNavigationBarWithTitle(title: title)
        
        self.uploadProductButton.setTitle("Upload \(String(describing: typeText))", for: .normal)

        self.navigationItem.titleView = titleLabel
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        self.navigationItem.hidesBackButton = true
        
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "backButtonIcon"), style: .plain, target: self, action: #selector(self.backButtonPressed(sender:)))
        
        self.navigationItem.leftBarButtonItem = backButton
        
    }
    
    func backButtonPressed(sender: UIBarButtonItem) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    private func configureData() {
        
        guard let product = self.productOptional else { return }
        
        let typeText = self.type == .shop ? "product" : "service"
        
        self.uploadProductButton.setTitle("Update \(typeText)", for: .normal)
        
        if let photos = product.photos {
            
            self.addPhotoButton.setTitle(nil, for: .normal)
            
            self.addPhotoButton.setImage(nil, for: .normal)
                        
            for image in photos {
                                
                if let src = image.src {
                    
                    self.imageLoader.obtainImageWithPath(imagePath: BASE_PUBLIC_IMAGE_URL + src) { image in
                        
                        if image == #imageLiteral(resourceName: "placeholderImage") { return }
                        
                        self.photosView.images.insert(image, at: 0)
                        
                        self.addPhotoButton.setImage(image, for: .normal)
                        
                        self.photosView.collectionView.reloadData()
                        
                    }
                    
                }
                
            }
            
        }
        
        self.photosView.isHidden = false
        
        self.heightConstraint.constant = HEIGHT_BIG
        
        self.descriptionView.itemTitleTextField.text = product.name
        
        self.descriptionView.selectCategoryButton.setTitle(product.categoryName, for: .normal)
        
        self.descriptionView.selectCategoryButton.setTitleColor(.black, for: .normal)
        
        self.selectedCategoryId = product.category
        
        self.descriptionView.itemPriceTextField.text = product.price!
        
        if let lat = product.lat, let lon = product.lon {
            
            self.itemLocationView.configureLocationViewWith(lat: Double(lat)!, lon: Double(lon)!)
            
            self.itemLocationView.userLocationLabel.text = product.pointName
            
            self.selectedLat = lat
            
            self.selectedLon = lon
            
        }
        
        self.descriptionView.descriptionTextView.text = product.description
        
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
        
        if self.photosView.images.count == 5 {
            
            self.showOkAlertWith(title: "Info", message: "You can add a maximum of 5 photos.")
            
            return
            
        }
        
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
        
        controller.configureWith(productImage: self.photosView.images.first!, delegate: self)
        
        self.presentViewController(controller)
        
    }
    
    fileprivate func showServicePaymentPopupViewController() {
        
        let factory = SecondaryViewControllerFactory.viewControllerFactory()
        
        let controller = factory.servicePaymentPopupViewController(delegate: self)
        
        controller.modalPresentationStyle = .overCurrentContext
        
        controller.modalTransitionStyle = .crossDissolve
                
        self.presentViewController(controller)
        
    }
    
    fileprivate func showMyProductsViewController() {
        
        let factory = SecondaryViewControllerFactory.viewControllerFactory()
        
        let controller = factory.myProductViewController(type: self.type)
        
        self.navigationController?.pushViewController(controller, animated: true)

    }
    
    private func validate() {

//        let text = self.type == .shop ? "product" : "service"
        
//        if self.descriptionView.itemTitleTextField.text == "" {
//
//            self.showOkAlertWith(title: "Info", message: "Please enter the \(text) name.")
//
//            return
//
//        }
//
//        if self.descriptionView.selectCategoryButton.titleLabel?.text == "Add category" {
//
//            self.showOkAlertWith(title: "Info", message: "Please select a category.")
//
//            return
//
//        }
//
//        if self.descriptionView.itemPriceTextField.text == "" {
//
//            self.showOkAlertWith(title: "Info", message: "Please enter the \(text) price.")
//
//            return
//
//        }
//
//        if self.descriptionView.descriptionTextView.text == "Add description" {
//
//            self.showOkAlertWith(title: "Info", message: "Please enter the \(text) description.")
//
//            return
//
//        }
//
//        if self.photosView.images.count == 0 {
//
//            self.showOkAlertWith(title: "Info", message: "Please add a \(text) photo.")
//
//            return
//
//        }
//
//        if self.selectedLat == nil || self.selectedLon == nil {
//
//            self.showOkAlertWith(title: "Info", message: "Please add your location.")
//
//            return
//
//        }
        
        if self.type == .shop {
            
            if self.productOptional == nil {
                
                self.addProduct()
                
            } else {
                
                self.updateProduct()
                
            }
            
        } else {
            
            self.showServicePaymentPopupViewController()
            
        }
        
    }
    
    private func addProduct() {
        
        guard let token = self.appContext.token() else { return }

        self.progressHUD.showLoading()
        
        self.shopService.addShopProduct(name: self.descriptionView.itemTitleTextField.text!,
                                        description: self.descriptionView.descriptionTextView.text!,
                                        price: self.descriptionView.itemPriceTextField.text!,
                                        category: String(self.selectedCategoryId!),
                                        token: token,
                                        lat: self.selectedLat!,
                                        lon: self.selectedLon!,
                                        pointName: self.itemLocationView.userLocationLabel.text!,
                                        images: self.photosView.images) { errorOptional in
            
                                        self.progressHUD.dismiss()
                                            
                                        if let error = errorOptional {
                                                
                                            print(error.localizedDescription)
                                                
                                        } else {
                                                
                                            self.showProductAddedPopupViewController()
                                                
                                        }
            
        }
        
    }
    
    private func updateProduct() {
        
        guard let token = self.appContext.token(), let id = self.productOptional?.id else { return }
        
        self.progressHUD.showLoading()
        
        self.shopService.updateShopProduct(id: String(id),
                                           name: self.descriptionView.itemTitleTextField.text!,
                                           description: self.descriptionView.descriptionTextView.text!,
                                           price: self.descriptionView.itemPriceTextField.text!,
                                           category: String(self.selectedCategoryId!),
                                           token: token,
                                           lat: self.selectedLat!,
                                           lon: self.selectedLon!,
                                           pointName: self.itemLocationView.userLocationLabel.text!,
                                           images: self.photosView.images) { errorOptional in
                                            
                                            self.progressHUD.dismiss()
                                            
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
        
        if self.photosView.images.count == 5 {
            
            self.showOkAlertWith(title: "Info", message: "You can add a maximum of 5 photos.")
            
            return
            
        }
        
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
    
    func selectedImage(tag: Int) {
        
        let image = self.photosView.images[tag]
        
        self.addPhotoButton.setImage(image, for: .normal)
        
        let i = self.photosView.images.remove(at: tag)
        
        self.photosView.images.insert(i, at: 0)
        
        let indexPathFrom = IndexPath(row: tag + 1, section: 0)
        
        let indexPathTo = IndexPath(row: 1, section: 0)
        
        self.photosView.collectionView.moveItem(at: indexPathFrom, to: indexPathTo)
        
        var indexPaths: [NSIndexPath] = []
        
        for i in 0..<self.photosView.collectionView!.numberOfItems(inSection: 0) {
        
            indexPaths.append(NSIndexPath(item: i, section: 0))
        
        }
        
       self.photosView.collectionView?.reloadItems(at: indexPaths as [IndexPath])
        
    }
    
}

extension AddProductViewController: AddProductDescriptionViewDelegate {
    
    func showShopCategoriesViewController() {
        
        let factory = SecondaryViewControllerFactory.viewControllerFactory()
        
        let controller = factory.shopCategoriesViewController(delegate: self, type: self.type)
        
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

extension AddProductViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
       
        guard textField == self.descriptionView.itemPriceTextField else { return false }
        
        let text = (textField.text ?? "") as NSString
        
        let newText = text.replacingCharacters(in: range, with: string)
        
        if let regex = try? NSRegularExpression(pattern: "^[0-9]*((\\.|,)[0-9]{0,2})?$", options: .caseInsensitive) {
        
            return regex.numberOfMatches(in: newText, options: .reportProgress, range: NSRange(location: 0, length: (newText as NSString).length)) > 0
        
        }
        
        return false
    
    }
    
}

extension AddProductViewController: ServicePaymentPopupViewControllerDelegate {
    
    func paid() {
        
        self.showMyProductsViewController()
        
    }
    
}
