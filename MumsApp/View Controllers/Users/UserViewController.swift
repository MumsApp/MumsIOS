import UIKit
import GoogleMaps

let KIDS_CELL = "KidsCell"
let ADD_CONTACT_CELL = "AddContactCell"
let REMOVE_CONTACT_CELL = "RemoveContactCell"

let k_data = "data"

enum UserViewType {
    
    case add
    case remove
    
}

class UserViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!

    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var userDescriptionTextView: UITextView!
    
    @IBOutlet weak var numberOfKidsLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
   
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
   
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!

    @IBOutlet weak var locationView: ItemLocationView!
    
    private var userId: String!
    
    private var userDetailsService: UserDetailsService!
    
    private var userDetails: UserDetails?
    
    fileprivate var childrenList: Array<Children> = []
    
    func configureWith(userId: String, userDetailsService: UserDetailsService) {
        
        self.userId = userId
        
        self.userDetailsService = userDetailsService
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.configureView()
    
        self.configureTableView()
        
        self.configureNavigationBar()
        
    }

    private func configureView() {
        
        self.view.setBackground()
        
        self.heightConstraint.constant = 750
        
        self.userImageView.layer.cornerRadius = 35
                
        self.userNameLabel.font = .regular(size: 20)
        
        self.userNameLabel.textColor = .black
        
        self.userDescriptionTextView.font = .regular(size: 12)
        
        self.userDescriptionTextView.textColor = .mainDarkGrey
     
        self.numberOfKidsLabel.font = .regular(size: 13)
        
        self.numberOfKidsLabel.textColor = .mainDarkGrey
        
        self.containerView.addShadow()
        
        self.tableView.addShadow()
        
        self.getUserDetails()
        
    }
    
    private func configureTableView() {
        
        self.tableView.delegate = self
        
        self.tableView.dataSource = self
        
        self.tableView.backgroundColor = .clear
        
        self.tableView.tableFooterView = UIView()

        self.tableView.registerNib(AddCell.self)

    }
    
    private func configureNavigationBar() {
        
        let titleLabel = self.navigationController?.configureNavigationBarWithTitle(title: "User Profile")
        
        self.navigationItem.titleView = titleLabel
        
        self.navigationItem.hidesBackButton = true
        
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "backButtonIcon"), style: .plain, target: self, action: #selector(self.backButtonPressed(sender:)))
        
        self.navigationItem.leftBarButtonItem = backButton
        
    }
    
    func backButtonPressed(sender: UIBarButtonItem) {
        
        self.navigationController?.popViewController(animated: true)
        
        
    }
    
    private func getUserDetails() {

        guard let token = self.appContext.token() else { return }

        self.userDetailsService.getUserDetails(id: self.userId, token: token) { dataOptional, errorOptional in
            
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
            
            self.userNameLabel.text = name + " " + surname
            
        }
        
        if let description = userDetails.description {
            
            self.userDescriptionTextView.text = description
            
        } else {
            
            self.userDescriptionTextView.text = "This user has not added a description about himself."
            
        }
        
        if let children = userDetails.children {
            
            self.childrenList = children
            
            self.tableView.reloadData()
            
        }
        
        if let location = userDetails.location {
            
            if let lat = location.lat, let lon = location.lon, let enabled = location.enabled, enabled {
                
                self.locationView.mapView.addMarker(lat: lat, lon: lon)
                
                let locationCoordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
                
                let cameraUpdate = GMSCameraUpdate.setTarget(locationCoordinate, zoom: 12)
                
                self.locationView.mapView.animate(with: cameraUpdate)
                
                self.locationView.userLocationLabel.text = location.formattedAddress
                
            } else {
                
                self.locationView.mapView.clear()
                
                self.locationView.userLocationLabel.text = "The location for this user is unknown."

            }
            
        }
        
        if let photoURL = userDetails.photo?.src {
            
            let url = BASE_PUBLIC_IMAGE_URL + photoURL
            
            self.userImageView.downloadedFrom(link: url)
            
        }
        
        self.updateChildrenView()
        
    }
    
    private func updateChildrenView() {
        
        if self.childrenList.count == 0 {
            
            self.tableViewHeight.constant = 120

            self.heightConstraint.constant = 750
            
        } else {

            self.tableViewHeight.constant = CGFloat(80 + self.childrenList.count * 40)

            self.heightConstraint.constant = 630 + self.tableViewHeight.constant

        }
        
        UIView.animate(withDuration: 0.3) {
            
            self.view.layoutIfNeeded()
            
        }
        
    }
    
}

extension UserViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
  
        if self.childrenList.count == 0 {

            return 1
            
        } else {
            
            return self.childrenList.count

        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 40
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: KIDS_CELL, for: indexPath) as! KidsCell
        
        if self.childrenList.count == 0 {
            
            cell.kidsLabel.text = "This user has no children."
            
        } else {
            
            let thisObject = self.childrenList[indexPath.row]

            cell.kidsLabel.text = thisObject.formatter()

        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return 80
        
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let type: UserViewType = .add
        
        if type == .add {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: ADD_CONTACT_CELL) as! AddContactCell
            
            cell.configureWith(delegate: self)
            
            return cell
            
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: REMOVE_CONTACT_CELL) as! RemoveContactCell
            
            cell.configureWith(delegate: self)
            
            return cell
            
        }
        
    }

}

extension UserViewController: AddCellDelegate, RemoveContactCellDelegate {
    
    func addButtonPressed() {
        
        print("ADD")
    
    }
    
    func removeButtonPressed() {
        
//        self.showRemoveCompanyPopupViewController()
        self.showRemoveContactPopupViewController()
        
    }
    
    private func showRemoveContactPopupViewController() {
        
        let factory = SecondaryViewControllerFactory.viewControllerFactory()
        
        let controller = factory.removeContactPopupViewController()
        
        controller.modalPresentationStyle = .overCurrentContext
        
        controller.modalTransitionStyle = .crossDissolve
        
        self.presentViewController(controller)
        
    }
    
    private func showRemoveCompanyPopupViewController() {
        
        let factory = SecondaryViewControllerFactory.viewControllerFactory()
        
        let controller = factory.removeCompanyPopupViewController()
        
        controller.modalPresentationStyle = .overCurrentContext
        
        controller.modalTransitionStyle = .crossDissolve
        
        self.presentViewController(controller)
        
    }
    
}
