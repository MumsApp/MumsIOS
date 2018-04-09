import UIKit
import GoogleMaps

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var profileView: ProfileView!
    
    @IBOutlet weak var locationView: LocationView!
    
//    @IBOutlet weak var schoolView: SchoolView!
    
    @IBOutlet weak var locationViewHeight: NSLayoutConstraint!
    
//    @IBOutlet weak var schoolViewHeight: NSLayoutConstraint!
    
    fileprivate var userDetailsService: UserDetailsService!
    
    fileprivate let imagePicker: UIImagePickerController = UIImagePickerController()

    fileprivate weak var userNamePopupViewController: UserNamePopupViewController?
    
    fileprivate var userDetails: UserDetails?
    
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    func configureWith(userDetailsService: UserDetailsService) {
        
        self.userDetailsService = userDetailsService
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.configureView()
    
        self.configureNavigationBar()
        
        self.getUserData()
        
    }
    
    func configureView() {
        
        self.view.backgroundColor = .backgroundWhite
        
        self.profileView.userNameLabel.text = "Test Name"
        
        self.locationView.configureWith(delegate: self)
        
        self.locationViewHeight.constant = 80

        self.profileView.configureWith(delegate: self)
     
        self.imagePicker.delegate = self
        
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
    
    private func getUserData() {
        
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
        
//        self.profileView.userImageView.image = self
        
        if let name = userDetails.name, let surname = userDetails.surname {
            
            self.profileView.userNameLabel.text = name + " " + surname
   
        }
        
        if let description = userDetails.description {
            
            self.profileView.userDescriptionLabel.text = description
            
        }
        
        if let location = userDetails.location {
            
            self.locationView.mapView.addMarker(lat: Double(location.lat!)!, lon: Double(location.lon!)!)
            
            let locationCoordinate = CLLocationCoordinate2D(latitude: Double(location.lat!)!, longitude: Double(location.lon!)!)

            let cameraUpdate = GMSCameraUpdate.setTarget(locationCoordinate, zoom: 12)
            
            self.locationView.mapView.animate(with: cameraUpdate)

            self.locationView.userLocationLabel.text = location.formattedAddress
            
            self.showSwitchValueChanged(isVisible: true)
            
        } else {
            
            self.showSwitchValueChanged(isVisible: false)

        }
        
    }
    
    fileprivate func updateUserPhoto() {
        
        guard let id = self.appContext.userId(), let token = self.appContext.token() else { return }

        guard let photoData = UIImageJPEGRepresentation(self.profileView.userImageView.image!, 0.7) else { return }
        
        self.userDetailsService.updateUserPhoto(id: id, token: token, photo: photoData) { errorOptional in
            
            if let error = errorOptional {
                
                print(error.localizedDescription)
                
            } else {
                
                
            }
            
        }
        
    }
    
}

//extension ProfileViewController: SchoolViewDelegate {
//
//    func addSchoolButtonPressed() {
//
//        self.schoolView.list.append(String(Date().timeIntervalSinceNow))
//
//        self.schoolViewHeight.constant += 90
//
//        UIView.animate(withDuration: 0.3) {
//
//            self.schoolView.tableView.reloadData()
//
//            self.view.layoutIfNeeded()
//
//        }
//
//    }
//
//    func deleteSchoolButtonPressed() {
//
//        self.schoolView.list.removeLast()
//
//        self.schoolViewHeight.constant -= 90
//
//        UIView.animate(withDuration: 0.3) {
//
//            self.schoolView.tableView.reloadData()
//
//            self.view.layoutIfNeeded()
//
//        }
//
//    }
//
//}

extension ProfileViewController: LocationViewDelegate {
    
    func showSwitchValueChanged(isVisible: Bool) {
        
        if isVisible {
            
            self.locationViewHeight.constant = 270
            
            self.locationView.showSwitch.isOn = true
            
            self.locationView.editButton.isHidden = false
            
            self.heightConstraint.constant = 1200

            UIView.animate(withDuration: 0.3) {
                
                self.view.layoutIfNeeded()
                
            }
            
        } else {
            
            self.locationViewHeight.constant = 80
            
            self.locationView.showSwitch.isOn = false

            self.heightConstraint.constant = 1010

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
        
        let controller = factory.locationPopupViewController(delegate: self)
        
        controller.modalPresentationStyle = .overCurrentContext
        
        controller.modalTransitionStyle = .crossDissolve
        
        if let location = self.userDetails?.location {

            controller.locationOptional = location

        }
        
        self.presentViewController(controller)
        
    }
    
}

extension ProfileViewController: ProfileViewDelegate {
    
    func imageTapped() {
        
        self.showPhotoAlert(imagePicker: self.imagePicker)

    }
    
    func changeButtonPressed() {
        
        self.showUserNamePopupViewController()
        
    }
    
    private func showUserNamePopupViewController() {
        
        let factory = SecondaryViewControllerFactory.viewControllerFactory()
        
        let controller = factory.userNamePopupViewController()
        
        controller.modalPresentationStyle = .overCurrentContext
        
        controller.modalTransitionStyle = .crossDissolve
        
        controller.configureWith(delegate: self)
        
        self.userNamePopupViewController = controller
        
        self.presentViewController(controller)
        
    }

}

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        self.dismissViewController()
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {

            self.profileView.userImageView.image = pickedImage
            
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
        
    }
    
}
