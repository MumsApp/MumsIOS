import UIKit
import FBSDKLoginKit
import GoogleSignIn

class SignInViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var signInWithGoogleButton: UIButton!
   
    @IBOutlet weak var signInWithFacebookButton: UIButton!
   
    @IBOutlet weak var orLabel: UILabel!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signInButton: UIButton!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var forgetPasswordButton: UIButton!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private var loginService: LoginService!
    
    private var facebookService: FacebookService!

    private var googleService: GoogleService!
    
    private weak var delegate: IntroDelegate?
    
    func configureWith(loginService: LoginService, facebookService: FacebookService, googleService: GoogleService, delegate: IntroDelegate? = nil) {
        
        self.loginService = loginService
        
        self.facebookService = facebookService
        
        self.googleService = googleService
        
        self.delegate = delegate
        
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
        
    }
    
    func configureView() {
        
        self.contentView.backgroundColor = .backgroundWhite

        self.orLabel.font = .regular(size: 15)
        
        self.orLabel.textColor = .mainDarkGrey

        self.activityIndicator.isHidden = true
        
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
    
    func backButtonPressed(sender: UIBarButtonItem) {
        
        self.popToViewController(WelcomeViewController.self)
        
    }
    
    @IBAction func signInWithGoogleButtonPressed(_ sender: UIButton) {
   
        GIDSignIn.sharedInstance().delegate = self
        
        GIDSignIn.sharedInstance().uiDelegate = self
        
        GIDSignIn.sharedInstance().signIn()
        
    }
    
    @IBAction func signInWithFacebookButtonPressed(_ sender: UIButton) {

        self.registerWithFacebook()
    
    }
    
    @IBAction func signInButtonPressed(_ sender: UIButton) {
    
        self.validate()
        
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
    
    private func validate() {
        
        if self.emailTextField.text!.isEmpty || !self.emailTextField.text!.trim().isEmail() {
            
            self.showOkAlertWith(title: "Info", message: "Please enter a valid email address.")
            
            return
            
        }
        
        if self.passwordTextField.text!.isEmpty {
            
            self.showOkAlertWith(title: "Info", message: "Please enter your password.")
            
            return
            
        }
        
        let email = self.emailTextField.text!.trim()
        
        let password = self.passwordTextField.text!
        
        self.login(email: email, password: password)
        
    }

    private func login(email: String, password: String) {
        
        self.isScreenEnabled(enabled: false)
        
        self.loginService.login(email: email, password: password) { errorOptional in
            
            self.isScreenEnabled(enabled: true)

            if let error = errorOptional {
                
                self.showOkAlertWith(title: "Error", message: error.localizedDescription)
                
            } else {
                
                self.delegate?.didFinishIntroWithSuccess()
                
            }
            
        }
        
    }
    
    fileprivate func isScreenEnabled(enabled: Bool) {
        
        self.signInButton.isEnabled = enabled

        let title = enabled == false ? "" : "Sign in"
        
        self.signInButton.setTitle(title, for: .normal)
        
        self.activityIndicator.isHidden = enabled
        
        self.signInWithGoogleButton.isUserInteractionEnabled = enabled
        
        self.signInWithFacebookButton.isUserInteractionEnabled = enabled
        
        self.signUpButton.isEnabled = enabled

        self.emailTextField.isEnabled = enabled
        
        self.passwordTextField.isEnabled = enabled
        
        self.forgetPasswordButton.isEnabled = enabled
        
    }
    
    private func registerWithFacebook() {
        
        self.isScreenEnabled(enabled: false)

        if FBSDKAccessToken.current() != nil {
            
            self.facebookService.logout()
            
        }
        
        self.facebookService.performFacebookLogin(self) { tokenOptional, errorOptional -> Void in
            
            if let _ = errorOptional {
                
                self.isScreenEnabled(enabled: true)

                self.showOkAlertWith(title: "Error", message: "Authorization failed. Try again or choose a different authorization method.")
                
            } else {
                
                if let token = tokenOptional {
                    
                    self.loadFacebookProfile(token: token)
                    
                } else {
                    
                    self.isScreenEnabled(enabled: true)

                    self.showOkAlertWith(title: "Error", message: "Authorization failed. Try again or choose a different authorization method.")
                    
                }
                
            }
            
        }
        
    }
    
    private func loadFacebookProfile(token: String) {
        
        self.facebookService.getUserProfile(token) { facebookProfile, errorOptional -> Void in
            
            if let _ = errorOptional {
                
                self.isScreenEnabled(enabled: true)

                self.showOkAlertWith(title: "Error", message: "Authorization failed. Try again or choose a different authorization method.")
                
            } else {
                
                self.facebookService.register(facebookProfile: facebookProfile, completion: { errorOptional in
                    
                    if let error = errorOptional {
                        
                        if error.localizedDescription == Exceptions.USER_EXIST.rawValue {
                            
                            self.loginWithFacebook(facebookProfile: facebookProfile, token: token)
                            
                        } else {
                            
                            self.isScreenEnabled(enabled: true)

                            self.showOkAlertWith(title: "Error", message: "Authorization failed. Try again or choose a different authorization method.")
                            
                        }
                        
                    } else {
                        
                        self.loginWithFacebook(facebookProfile: facebookProfile, token: token)
                        
                    }
                    
                })
                
            }
            
        }
        
    }
    
    private func loginWithFacebook(facebookProfile: FacebookProfile, token: String) {
        
        self.facebookService.login(facebookProfile: facebookProfile, completion: { errorOptional -> Void in
            
            self.isScreenEnabled(enabled: true)

            if let _ = errorOptional {

                self.showOkAlertWith(title: "Error", message: "Authorization failed. Try again or choose a different authorization method.")
                
            } else {
                
                self.delegate?.didFinishIntroWithSuccess()
                
            }
            
        })
        
    }
    
    fileprivate func registerWithGoogle(googleProfile: GIDGoogleUser) {
        
        self.googleService.register(googleProfile: googleProfile) { errorOptional in
            
            if let error = errorOptional {
                
                if error.localizedDescription == Exceptions.USER_EXIST.rawValue {
                    
                    self.loginWithGoogle(googleProfile: googleProfile)

                } else {
                    
                    self.isScreenEnabled(enabled: true)

                    self.showOkAlertWith(title: "Error", message: "Authorization failed. Try again or choose a different authorization method.")
                    
                }
                
            } else {
                
                self.loginWithGoogle(googleProfile: googleProfile)
                
            }
            
        }
        
    }
    
    private func loginWithGoogle(googleProfile: GIDGoogleUser) {
        
        self.googleService.login(googleProfile: googleProfile) { errorOptional in
            
            self.isScreenEnabled(enabled: true)

            if let _ = errorOptional {

                self.showOkAlertWith(title: "Error", message: "Authorization failed. Try again or choose a different authorization method.")
                
            } else {
                
                self.delegate?.didFinishIntroWithSuccess()
                
            }
            
        }
        
    }
    
}

extension SignInViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == self.emailTextField {
            
            self.passwordTextField.becomeFirstResponder()
            
        } else if textField == self.passwordTextField {
            
            self.view.endEditing(true)

        }
        
        return true
        
    }
    
}

extension SignInViewController: GIDSignInDelegate, GIDSignInUIDelegate {
    
    func sign(inWillDispatch signIn: GIDSignIn!, error: Error!) {
        
    }
    
    func sign(_ signIn: GIDSignIn!, present viewController: UIViewController!) {
        
        self.present(viewController, animated: true, completion: nil)
        
    }
    
    func sign(_ signIn: GIDSignIn!, dismiss viewController: UIViewController!) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        self.isScreenEnabled(enabled: false)

        if let error = error {

            self.isScreenEnabled(enabled: true)

            self.showOkAlertWith(title: "Error", message: error.localizedDescription)
            
        } else {
            
            self.registerWithGoogle(googleProfile: user)
            
        }
        
    }
    
}
