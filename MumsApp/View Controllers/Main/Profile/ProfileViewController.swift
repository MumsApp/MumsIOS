import UIKit
import GoogleMaps

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var profileView: ProfileView!
    
    @IBOutlet weak var locationView: LocationView!
    
    @IBOutlet weak var childrenView: ChildrenView!

    @IBOutlet weak var cardsView: CardsView!
    
    @IBOutlet weak var offersView: OffersView!
    
    @IBOutlet weak var friendsView: FriendsView!

    @IBOutlet weak var heightConstraint: NSLayoutConstraint!

    @IBOutlet weak var profileViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var locationViewHeight: NSLayoutConstraint!

    @IBOutlet weak var childrenViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var cardsViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var offersViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var friendsViewHeight: NSLayoutConstraint!
    
    fileprivate var userDetailsService: UserDetailsService!
    
    fileprivate var childService: ChildService!
    
    fileprivate var userImageService: UserImageService!
    
    fileprivate let imagePicker: UIImagePickerController = UIImagePickerController()

    fileprivate weak var userNamePopupViewController: UserNamePopupViewController?
    
    fileprivate var userDetails: UserDetails?
    
    func configureWith(userDetailsService: UserDetailsService, childService: ChildService, userImageService: UserImageService) {
        
        self.userDetailsService = userDetailsService
        
        self.childService = childService
        
        self.userImageService = userImageService
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.configureView()
    
        self.configureNavigationBar()
        
        self.getUserData()
        
    }
    
    
    func configureView() {
        
        self.view.setBackground()

        self.profileView.userNameLabel.text = ""
        
        self.locationView.configureWith(delegate: self)
        
        self.profileView.configureWith(delegate: self)
     
        self.imagePicker.delegate = self

        self.locationViewHeight.constant = 80

        self.heightConstraint.constant = 1270

        self.childrenView.configureWith(delegate: self)
        
    }

    private func configureNavigationBar() {
        
        let titleLabel = self.navigationController?.configureNavigationBarWithTitle(title: "My Profile")
        
        self.navigationItem.titleView = titleLabel
        
        self.navigationItem.hidesBackButton = true
        
        let settingsButton = UIBarButtonItem(image: #imageLiteral(resourceName: "settingsIcon"), style: .plain, target: self, action: #selector(self.settingsButtonPressed(sender:)))
        
        self.navigationItem.rightBarButtonItem = settingsButton
        
    }
    
    func settingsButtonPressed(sender: UIBarButtonItem) {
        
        self.showProfileSettingsPopupViewController()
        
    }
    
    private func showProfileSettingsPopupViewController() {
        
        let factory = SecondaryViewControllerFactory.viewControllerFactory()
        
        let controllers = self.navigationController?.viewControllers
        
        let rootViewController = controllers?.first(where: { $0.isKind(of: MainRootViewController.self) })
        
        let controller = factory.profileSettingsPopupViewController(mainRootViewController: rootViewController)
        
        controller.modalPresentationStyle = .overCurrentContext
        
        controller.modalTransitionStyle = .crossDissolve
        
        self.presentViewController(controller)
        
    }
    
    fileprivate func getUserData() {
        
        guard let id = self.appContext.userId(), let token = self.appContext.token() else { return }
        
        self.userDetailsService.getUserDetails(id: id, token: token) { dataOptional, errorOptional in
            
            if let error = errorOptional {
                
                self.showOkAlertWith(title: "Error", message: error.localizedDescription)
                
            } else {
                
                guard let data = dataOptional as? StorableDictionary,
                    let dictionary = data[k_data] as? StorableDictionary else {
                    
                        return
                
                }
                
                self.userDetails = UserDetails(dictionary: dictionary)
                
                self.configureViewWithData(userDetails: self.userDetails!)
                
            }
            
        }
        
    }
    
    private func configureViewWithData(userDetails: UserDetails) {
        
        if let name = userDetails.name, let surname = userDetails.surname {
            
            self.profileView.userNameLabel.text = name + " " + surname
   
        }
        
        if let description = userDetails.description {
            
            self.profileView.userDescriptionLabel.text = description
            
        } else {
            
            self.showOkAlertWith(title: "Info", message: "Tell us something about yourself.") { _ in
                
                self.showUserNamePopupViewController()

            }
            
        }
        
        if let children = userDetails.children {
            
            self.childrenView.childrenList = children
            
            self.childrenView.tableView.reloadData()
            
        }
        
        if let location = userDetails.location {
            
            if let lat = location.lat, let lon = location.lon {
                
                self.locationView.mapView.addMarker(lat: lat, lon: lon)
                
                let locationCoordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
                
                let cameraUpdate = GMSCameraUpdate.setTarget(locationCoordinate, zoom: 12)
                
                self.locationView.mapView.animate(with: cameraUpdate)
                
                self.locationView.userLocationLabel.text = location.formattedAddress
                
            }
            
            if let enabled = location.enabled, enabled {
                
                self.showSwitchValueChanged(isVisible: true)
                
            } else {
                
//                self.showSwitchValueChanged(isVisible: false)
                
            }
            
        }
        
        self.profileView.userImageView.loadImage(urlStringOptional: userDetails.photo?.src)
        
        self.updateChildrenView()

    }
    
    fileprivate func updateUserPhoto() {
        
        guard let id = self.appContext.userId(), let token = self.appContext.token() else { return }
      
        self.userImageService.postNewUserImage(id: id, token: token, image: self.profileView.userImageView.image!) { errorOptional in
            
            if let error = errorOptional {
                
                print(error.localizedDescription)
                
            } else {
                
                
            }
 
        }
 
    }
    
    fileprivate func updateChildrenView() {
        
        if self.childrenView.childrenList.count == 0 {
            
            self.childrenView.separatorView.isHidden = true

            self.childrenViewHeight.constant = 175
            
            self.updateViewHeight()

            UIView.animate(withDuration: 0.3) {
                
                self.view.layoutIfNeeded()
                
            }
            
        } else {
            
            self.childrenView.separatorView.isHidden = false
            
            self.childrenViewHeight.constant = 175 + CGFloat(self.childrenView.childrenList.count) * 40
            
            self.updateViewHeight()

            UIView.animate(withDuration: 0.3) {
                
                self.view.layoutIfNeeded()
                
            
            }
            
        }
        
    }
    
    fileprivate func updateViewHeight() {
        
        self.heightConstraint.constant = self.profileViewHeight.constant +
            self.locationViewHeight.constant +
            self.childrenViewHeight.constant +
            self.cardsViewHeight.constant +
            self.offersViewHeight.constant +
            self.friendsViewHeight.constant + 200
        
    }
    
}

extension ProfileViewController: LocationViewDelegate {
    
    func showSwitchValueChanged(isVisible: Bool) {
        
        if isVisible {
            
            self.locationViewHeight.constant = 270
            
            self.locationView.showSwitch.isOn = true
            
            self.locationView.editButton.isHidden = false
            
            self.enableLocation(bool: true)

            if self.userDetails?.location?.lat == nil {
                
                self.showLocationPopupViewController()

            }
            
            self.updateViewHeight()

            UIView.animate(withDuration: 0.3) {
                
                self.view.layoutIfNeeded()
                
            }
            
        } else {
            
            self.locationViewHeight.constant = 80
            
            self.locationView.showSwitch.isOn = false

            self.locationView.editButton.isHidden = true
            
            self.enableLocation(bool: false)
            
            self.updateViewHeight()

            UIView.animate(withDuration: 0.3) {
                
                self.view.layoutIfNeeded()
                
            }
            
        }
        
    }
    
    func changeLocationButtonPressed() {
        
        self.showLocationPopupViewController()
        
    }
    
    private func showLocationPopupViewController() {
        
        let factory = SecondaryViewControllerFactory.viewControllerFactory()
        
        let controller = factory.locationPopupViewController(delegate: self, type: .profile)
        
        controller.modalPresentationStyle = .overCurrentContext
        
        controller.modalTransitionStyle = .crossDissolve
        
        if let location = self.userDetails?.location {

            controller.locationOptional = location

        }
        
        self.presentViewController(controller)

    }
    
    fileprivate func showAddChildrenPopupViewController(type: ChildrenType, children: Children?) {
        
        let factory = SecondaryViewControllerFactory.viewControllerFactory()
        
        let controller = factory.addChildrenPopupViewController(type: type, delegate: self, children: children)
        
        controller.modalPresentationStyle = .overCurrentContext
        
        controller.modalTransitionStyle = .crossDissolve
        
        self.presentViewController(controller)
        
    }
    
    fileprivate func showUserNamePopupViewController() {
        
        let factory = SecondaryViewControllerFactory.viewControllerFactory()
        
        let controller = factory.userNamePopupViewController()
        
        controller.modalPresentationStyle = .overCurrentContext
        
        controller.modalTransitionStyle = .crossDissolve
        
        controller.configureWith(delegate: self, userDetails: self.userDetails)
        
        self.userNamePopupViewController = controller
        
        self.presentViewController(controller)
        
    }
    
    private func enableLocation(bool: Bool) {
        
        guard let id = self.appContext.userId(), let token = self.appContext.token() else { return }
        
        self.userDetailsService.enableUserLocation(id: id, token: token, bool: bool) { errorOptional in
            
            if let error = errorOptional {
                
                self.showOkAlertWith(title: "Error", message: error.localizedDescription)
                
            } else {
                
                
            }
            
        }
        
    }
    
}

extension ProfileViewController: ProfileViewDelegate {
    
    func imageTapped() {
        
        self.showPhotoAlert(imagePicker: self.imagePicker)

    }
    
    func changeButtonPressed() {
        
        self.showUserNamePopupViewController()
        
    }
    
}

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        self.dismissViewController()
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {

            let newImage = pickedImage.crop(to: CGSize(width: 70, height: 70))
            
            self.profileView.userImageView.image = newImage
            
        }
        
        self.dismissViewController()
        
        self.updateUserPhoto()
        
    }
    
}

extension ProfileViewController: UserNamePopupDelegate {
    
    func saveUserDetails(firstName: String, lastName: String, description: String) {
        
        guard let id = self.appContext.userId(), let token = self.appContext.token() else { return }
        
        self.userDetailsService.updateUserName(id: id, token: token, name: firstName, surname: lastName, description: description) { errorOptional in
            
            if let error = errorOptional {
                
                if var topController = UIApplication.shared.keyWindow?.rootViewController {
                    while let presentedViewController = topController.presentedViewController {
                        topController = presentedViewController
                    }

                    self.userNamePopupViewController?.blockView(bool: false)
                    
                    topController.showOkAlertWith(title: "Error", message: error.localizedDescription)

                }
                
            } else {
                
                self.profileView.userNameLabel.text = firstName + " " + lastName
                
                self.profileView.userDescriptionLabel.text = description
                
                self.dismissViewController()
                
                self.userNamePopupViewController = nil
                
            }
            
        }
        
    }
    
}

extension ProfileViewController: LocationPopupDelegate {
    
    func locationUpdated(coordinate: CLLocationCoordinate2D, locationName: String) {
        
        self.locationView.mapView.clear()
        
        self.locationView.mapView.addMarker(lat: coordinate.latitude, lon: coordinate.longitude)
        
        let cameraUpdate = GMSCameraUpdate.setTarget(coordinate, zoom: 12)
        
        self.locationView.mapView.animate(with: cameraUpdate)
        
        self.locationView.userLocationLabel.text = locationName
        
        self.showSwitchValueChanged(isVisible: true)
        
        self.getUserData()
        
    }
    
    func locationNotSelected() {
        
        if let location = self.userDetails?.location, let _ = location.lat, let _ = location.lon {} else {
            
            self.showSwitchValueChanged(isVisible: false)

        }
        
    }
    
}

extension ProfileViewController: ChildrenViewDelegate {
    
    func addChildrenButtonPressed(type: ChildrenType) {
        
        self.showAddChildrenPopupViewController(type: type, children: nil)
        
    }
    
    func editChildrenButtonPressed(children: Children) {
        
        let type = ChildrenType(rawValue: children.sex!)!

        self.showAddChildrenPopupViewController(type: type, children: children)
        
    }
    
    func deleteChildrenButtonPressed(children: Children) {
        
        guard let id = self.appContext.userId(), let token = self.appContext.token() else { return }

        self.childService.deleteChildDetails(id: id, child_id: children.id!, token: token) { errorOptional in
            
            if let error = errorOptional {
                
                self.showOkAlertWith(title: "Error", message: error.localizedDescription)
                
            } else {
                
                self.getUserData()
                
            }
            
        }
        
    }
    
}

extension ProfileViewController: AddChildrenPopupViewControllerDelegate {
    
    func saveChildrenButtonPressed() {
        
        self.getUserData()
        
    }
    
}
