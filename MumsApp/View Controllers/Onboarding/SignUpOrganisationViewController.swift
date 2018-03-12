import UIKit

class SignUpOrganisationViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var companyNameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var signInButton: UIButton!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var verifyButton: UIButton!

    @IBOutlet weak var verifyLabel: UILabel!
    
    @IBOutlet weak var termsButton: UIButton!
    
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
        
        self.activityIndicator.isHidden = true
        
        self.verifyLabel.textColor = .mainDarkGrey
        
        self.verifyLabel?.font = .medium(size: 15)
    
    }
    
    private func configureTextFields() {
        
        self.companyNameTextField.delegate = self
        
        self.emailTextField.delegate = self
        
        self.passwordTextField.delegate = self
        
        self.confirmPasswordTextField.delegate = self
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
        
    }
    
    private func configureNavigationBar() {
        
        let titleLabel = self.navigationController?.configureNavigationBarWithTitle(title: "Create Company Page")
        
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
    
    @IBAction func verifyButtonPressed(_ sender: UIButton) {

        let image = sender.tag == 0 ? #imageLiteral(resourceName: "onIcon") : #imageLiteral(resourceName: "offIcon")
        
        sender.setImage(image, for: .normal)
        
        sender.tag = sender.tag == 0 ? 1 : 0
        
    }
    
    @IBAction func termsButtonPressed(_ sender: UIButton) {
        
        let image = sender.tag == 0 ? #imageLiteral(resourceName: "onIcon") : #imageLiteral(resourceName: "offIcon")
        
        sender.setImage(image, for: .normal)
        
        sender.tag = sender.tag == 0 ? 1 : 0
        
    }

    private func validate() {
        
        if self.companyNameTextField.text!.isEmpty {
            
            self.showOkAlertWith(title: "Info", message: "Please enter your company name.")
            
            return
            
        }
        
        if self.emailTextField.text!.isEmpty || !self.emailTextField.text!.trim().isEmail() {
            
            self.showOkAlertWith(title: "Info", message: "Please enter a valid email address.")
            
            return
            
        }
        
        if self.passwordTextField.text!.isEmpty {
            
            self.showOkAlertWith(title: "Info", message: "Please enter your password.")
            
            return
            
        }
        
        if self.passwordTextField.text!.count < 4 {
            
            self.showOkAlertWith(title: "Info", message: "The password must contain a minimum of 4 characters.")
            
            return
            
        }
        
        if self.passwordTextField.text! != self.confirmPasswordTextField.text! {
            
            self.showOkAlertWith(title: "Info", message: "The entered passwords are different.")
            
            return
            
        }
        
        if self.termsButton.tag == 0 {
            
            self.showOkAlertWith(title: "Info", message: "Please accept terms & conditions.")
            
            return
            
        }
        
        let email = self.emailTextField.text!.trim()
        
        let password = self.passwordTextField.text!
        
        let name = self.companyNameTextField.text!
        
    }
    
    fileprivate func isScreenEnabled(enabled: Bool) {
        
        self.signUpButton.isEnabled = enabled
        
        let title = enabled == false ? "" : "Sign up"
        
        self.signUpButton.setTitle(title, for: .normal)
        
        self.activityIndicator.isHidden = enabled
        
        self.signInButton.isEnabled = enabled
        
        self.companyNameTextField.isEnabled = enabled
        
        self.emailTextField.isEnabled = enabled
        
        self.passwordTextField.isEnabled = enabled
        
        self.confirmPasswordTextField.isEnabled = enabled
        
    }
    
    @IBAction func showTermsButtonPressed(_ sender: UIButton) {
        
        self.showTermsViewController()
        
    }
    
    private func showTermsViewController() {
        
        let factory = PrimaryViewControllerFactory.viewControllerFactory()
        
        let controller = factory.termsViewController()
        
        self.navigationController?.pushViewController(controller, animated: true)
        
    }
   
    @IBAction func signUpButtonPressed(_ sender: UIButton) {
    
        self.validate()
    
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

extension SignUpOrganisationViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == self.companyNameTextField {
      
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
