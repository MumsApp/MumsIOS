import UIKit

class SignInViewController: UIViewController {

    @IBOutlet weak var signInWithGoogleButton: UIButton!
   
    @IBOutlet weak var signInWithFacebookButton: UIButton!
   
    @IBOutlet weak var orLabel: UILabel!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signInButton: UIButton!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var forgetPasswordButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureView()
        
        self.configureNavigationBar()
     
        self.configureTextFields()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
        
    }
    
    func configureView() {
        
        self.view.backgroundColor = .backgroundWhite
        
        self.orLabel.font = .regular(size: 15)
        
        self.orLabel.textColor = .mainGrey

    }

    private func configureTextFields() {
        
        self.emailTextField.delegate = self
        
        self.passwordTextField.delegate = self
        
    }
    
    private func configureNavigationBar() {
        
        let titleLabel = self.navigationController?.configureNavigationBarWithTitle(title: "Sign In")
        
        self.navigationItem.titleView = titleLabel

        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        self.navigationItem.hidesBackButton = true
        
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "backButtonIcon"), style: .plain, target: self, action: #selector(self.backButtonPressed(sender:)))
        
        self.navigationItem.leftBarButtonItem = backButton
        
    }
    
    func backButtonPressed(sender: UIBarButtonItem) {
        
        self.popToViewController(WelcomeViewController.self)
        
    }
    
    @IBAction func signInButtonPressed(_ sender: UIButton) {
    
        // Request
    
    }
    
    @IBAction func signUpButtonPressed(_ sender: UIButton) {
   
        self.showSignUpViewController()
    
    }
    
    @IBAction func forgetPasswordButtonPressed(_ sender: UIButton) {
    
        self.showForgotPasswordViewController()
    
    }
    
    private func showSignUpViewController() {
        
        let factory = PrimaryViewControllerFactory.viewControllerFactory()
        
        let controller = factory.signUpViewController()
        
        self.navigationController?.pushViewController(controller, animated: true)
        
    }
    
    private func showForgotPasswordViewController() {
        
        let factory = PrimaryViewControllerFactory.viewControllerFactory()
        
        let controller = factory.forgotPasswordViewController()
        
        self.navigationController?.pushViewController(controller, animated: true)
        
    }
}

extension SignInViewController: UITextFieldDelegate {
    
    
    
}
