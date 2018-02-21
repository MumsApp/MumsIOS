import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var profileView: ProfileView!
    
    @IBOutlet weak var locationView: LocationView!
    
    @IBOutlet weak var schoolView: SchoolView!
    
    @IBOutlet weak var locationViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var schoolViewHeight: NSLayoutConstraint!
    
    private var userDataService: UserDataService!
    
    func configureWith(userDataService: UserDataService) {
        
        self.userDataService = userDataService
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.configureView()
    
        self.configureNavigationBar()
        
        self.getUserData()
        
    }
    
    func configureView() {
        
        self.view.backgroundColor = .backgroundWhite
        
        self.schoolView.configureWith(delegate: self)
        
        self.profileView.userNameLabel.text = "Test Name"
        
        self.locationView.configureWith(delegate: self)
        
        self.locationViewHeight.constant = 80

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
        
        self.userDataService.getUserData(id: id, token: token) { errorOptional in
            
            if let error = errorOptional {
                
                self.showOkAlertWith(title: "Error", message: error.localizedDescription)
                
            } else {
                
                print("success")
                
            }
            
        }
        
    }
    
}

extension ProfileViewController: SchoolViewDelegate {
    
    func addSchoolButtonPressed() {
        
        self.schoolView.list.append(String(Date().timeIntervalSinceNow))
        
        self.schoolViewHeight.constant += 90
        
        UIView.animate(withDuration: 0.3) {
        
            self.schoolView.tableView.reloadData()
            
            self.view.layoutIfNeeded()
            
        }
        
    }
    
    func deleteSchoolButtonPressed() {

        self.schoolView.list.removeLast()

        self.schoolViewHeight.constant -= 90
        
        UIView.animate(withDuration: 0.3) {
            
            self.schoolView.tableView.reloadData()
            
            self.view.layoutIfNeeded()
            
        }
        
    }
    
}

extension ProfileViewController: LocationViewDelegate {
    
    func showSwitchValueChanged(isVisible: Bool) {
        
        if isVisible {
            
            self.locationViewHeight.constant = 270
            
            UIView.animate(withDuration: 0.3) {
                
                self.view.layoutIfNeeded()
                
            }
            
        } else {
            
            self.locationViewHeight.constant = 80
            
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
        
        let controller = factory.locationPopupViewController()
        
        controller.modalPresentationStyle = .overCurrentContext
        
        controller.modalTransitionStyle = .crossDissolve
        
        self.presentViewController(controller)
        
    }
    
}
