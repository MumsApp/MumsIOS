import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var signUpWithGoogleButton: UIButton!
    
    @IBOutlet weak var signUpWithFacebookButton: UIButton!
    
    @IBOutlet weak var orLabel: UILabel!
    
    @IBOutlet weak var firstNameTextField: UITextField!
   
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var signInButton: UIButton!

    private var registerService: RegisterService!
    
    private var loginService: LoginService!
    
    func configureWith(registerService: RegisterService, loginService: LoginService) {
        
        self.registerService = registerService
        
        self.loginService = loginService
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.configureView()
        
        self.configureNavigationBar()
        
        self.configureTextFields()
        
    }
    
    func configureView() {
        
        self.view.backgroundColor = .backgroundWhite
        
        self.orLabel.font = .regular(size: 15)
        
        self.orLabel.textColor = .mainGrey
        
    }
    
    private func configureTextFields() {
        
        self.firstNameTextField.delegate = self
        
        self.lastNameTextField.delegate = self
        
        self.emailTextField.delegate = self
        
        self.passwordTextField.delegate = self
        
        self.confirmPasswordTextField.delegate = self
     
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
        
    }
    
    private func configureNavigationBar() {
        
        let titleLabel = self.navigationController?.configureNavigationBarWithTitle(title: "Sign Up")

        self.navigationItem.titleView = titleLabel

        self.navigationController?.setNavigationBarHidden(false, animated: false)

        self.navigationItem.hidesBackButton = true
        
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "backButtonIcon"), style: .plain, target: self, action: #selector(self.backButtonPressed(sender:)))
            
        self.navigationItem.leftBarButtonItem = backButton

    }
    
    func backButtonPressed(sender: UIBarButtonItem) {
        
       self.popToViewController(WelcomeViewController.self)
        
    }
   
    @IBAction func signUpButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func signInButtonPressed(_ sender: UIButton) {
    
        self.showSignInViewController()
    
    }
    
    private func showSignInViewController() {
        
        let factory = PrimaryViewControllerFactory.viewControllerFactory()
        
        let controller = factory.signInViewController()
        
        self.navigationController?.pushViewController(controller, animated: true)
        
    }
    
}

extension SignUpViewController: UITextFieldDelegate {
    
    
    
}
