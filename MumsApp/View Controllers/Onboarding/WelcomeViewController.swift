import UIKit

class WelcomeViewController: UIViewController {
    
    @IBOutlet var titleLabels: [UILabel]!
        
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var signInButton: UIButton!
    
    @IBOutlet weak var createOfficialPageButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.configureView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.configureNavigationBar()

    }
    
    func configureView() {
        
        self.view.backgroundColor = .backgroundWhite
        
        for labels in self.titleLabels {
            
            labels.font = .regular(size: 33)
            
        }
     
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
