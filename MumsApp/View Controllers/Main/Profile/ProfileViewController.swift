import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var profileView: ProfileView!
    
    @IBOutlet weak var schoolView: SchoolView!
    
    @IBOutlet weak var schoolViewHeightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.configureView()
    
        self.configureNavigationBar()
        
    }
    
    func configureView() {
        
        self.view.backgroundColor = .backgroundWhite
        
        self.schoolView.configureWith(delegate: self)
        
        self.profileView.userNameLabel.text = "Test Name"
        
    }

    private func configureNavigationBar() {
        
        let titleLabel = self.navigationController?.configureNavigationBarWithTitle(title: "My Profile")
        
        self.navigationItem.titleView = titleLabel
        
//        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        self.navigationItem.hidesBackButton = true
        
        let settingsButton = UIBarButtonItem(image: #imageLiteral(resourceName: "settingsIcon"), style: .plain, target: self, action: #selector(self.settingsButtonPressed(sender:)))
        
        self.navigationItem.rightBarButtonItem = settingsButton
        
    }
    
    func settingsButtonPressed(sender: UIBarButtonItem) {
        
        // Show settings
        
    }
    
}

extension ProfileViewController: SchoolViewDelegate {
    
    func addSchoolButtonPressed() {
        
        self.schoolView.list.append(String(Date().timeIntervalSinceNow))
        
        self.schoolViewHeightConstraint.constant += 90
        
        UIView.animate(withDuration: 0.3) {
        
            self.schoolView.tableView.reloadData()
            
            self.view.layoutIfNeeded()
            
        }
        
    }
    
    func deleteSchoolButtonPressed() {

        // remove selected object
        
        self.schoolViewHeightConstraint.constant -= 90
        
        UIView.animate(withDuration: 0.3) {
            
            self.schoolView.tableView.reloadData()
            
            self.view.layoutIfNeeded()
            
        }
        
    }
    
}
