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

        self.configureNavigationBar()
        
    }
    
    private func configureNavigationBar() {
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
                
    }
   
    @IBAction func signUpButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func signInButtonPressed(_ sender: UIButton) {
    }
    
}
