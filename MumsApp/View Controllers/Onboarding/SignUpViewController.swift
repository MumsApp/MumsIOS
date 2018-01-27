import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var contentView: UIView!
    
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
        
        self.addNotifationsForKeyboard()
        
        self.addGestureRecognizerToContentView()

    }
    
    deinit {
        
        NotificationCenter.default.removeObserver(self)
        
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
    
    private func addNotifationsForKeyboard() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasShown(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }
    
    func keyboardWasShown(notification: Notification) {
        
        let userInfo: NSDictionary = notification.userInfo! as NSDictionary
        
        let keyboardInfo = userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue
        
        let keyboardSize = keyboardInfo.cgRectValue.size
        
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        
        self.scrollView.contentInset = contentInsets
        
        self.scrollView.scrollIndicatorInsets = contentInsets
        
    }
    
    func keyboardWasHide(notification: Notification) {
        
        self.scrollView.contentInset = .zero
        
        self.scrollView.scrollIndicatorInsets = .zero
        
    }
    
    private func addGestureRecognizerToContentView() {
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.contentViewPressed(sender:)))
        
        self.contentView.addGestureRecognizer(gesture)
        
    }
    
    func contentViewPressed(sender: UITapGestureRecognizer) {
        
        self.view.endEditing(true)
        
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == self.firstNameTextField {
            
            self.lastNameTextField.becomeFirstResponder()
            
        } else if textField == self.lastNameTextField {
            
            self.emailTextField.becomeFirstResponder()
        
        } else if textField == self.emailTextField {
            
            self.passwordTextField.becomeFirstResponder()
            
        } else if textField == self.passwordTextField {
            
            self.confirmPasswordTextField.becomeFirstResponder()
            
        } else if textField == self.confirmPasswordTextField {
            
            self.view.endEditing(true)
            
        }

        return true
        
    }
    
}
