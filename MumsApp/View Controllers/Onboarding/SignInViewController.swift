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
        
        self.configureNavigationBar()
        
    }
    
    private func configureNavigationBar() {
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
    }

    @IBAction func signInButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func signUpButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func forgetPasswordButtonPressed(_ sender: UIButton) {
    }
    
}
