import UIKit

class WelcomeViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var signInButton: UIButton!
    
    @IBOutlet weak var createOfficialPageButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.configureNavigationBar()

    }
    
    private func configureNavigationBar() {

        self.navigationItem.setHidesBackButton(true, animated: true)
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)

    }

    @IBAction func signUpButtonPressed(_ sender: UIButton) {
    
        self.showSignUpViewController()
    
    }
    
    @IBAction func signInButtonPressed(_ sender: UIButton) {
   
        self.showSignInViewController()
    
    }
    
    @IBAction func createOfficialPageButtonPressed(_ sender: UIButton) {
    
        self.showCreateOfficialPageViewController()
    
    }
    
    private func showSignUpViewController() {
        
        let factory = PrimaryViewControllerFactory.viewControllerFactory()
        
        let controller = factory.signUpViewController()
        
        self.navigationController?.pushViewController(controller, animated: true)
        
    }
    
    private func showSignInViewController() {
        
        let factory = PrimaryViewControllerFactory.viewControllerFactory()
        
        let controller = factory.signInViewController()
        
        self.navigationController?.pushViewController(controller, animated: true)

    }
    
    private func showCreateOfficialPageViewController() {
        
        let factory = PrimaryViewControllerFactory.viewControllerFactory()
        
        let controller = factory.createOfficialPageViewController()
        
        self.navigationController?.pushViewController(controller, animated: true)

    }
    
}
