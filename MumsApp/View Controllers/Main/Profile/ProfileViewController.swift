import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var profileView: ProfileView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.configureView()
    
        self.configureNavigationBar()
        
    }
    
    func configureView() {
        
        self.view.backgroundColor = .backgroundWhite
        
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
