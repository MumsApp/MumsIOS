import UIKit

class ForgotPasswordViewController: UIViewController {

    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var sendPasswordButton: UIButton!

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    private var forgotPasswordService: ForgotPasswordService!
    
    func configureWith(forgotPasswordService: ForgotPasswordService) {
        
        self.forgotPasswordService = forgotPasswordService
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.configureView()
        
        self.configureNavigationBar()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.emailTextField.becomeFirstResponder()

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
        
    }
    
    func configureView() {
        
        self.view.backgroundColor = .backgroundWhite
        
        self.activityIndicator.isHidden = true
        
        self.descriptionLabel.font = .regular(size: 15)
        
        self.descriptionLabel.textColor = .black

        self.emailTextField.delegate = self
        
        self.activityIndicator.isHidden = true

    }
    
    private func configureNavigationBar() {
        
        let titleLabel = self.navigationController?.configureNavigationBarWithTitle(title: "Forgot password")
        
        self.navigationItem.titleView = titleLabel

        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        self.navigationItem.hidesBackButton = true
        
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "backButtonIcon"), style: .plain, target: self, action: #selector(self.backButtonPressed(sender:)))
        
        self.navigationItem.leftBarButtonItem = backButton
        
    }
    
    func backButtonPressed(sender: UIBarButtonItem) {
        
        self.popToViewController(WelcomeViewController.self)
        
    }
    
    @IBAction func sendPasswordButtonPressed(_ sender: UIButton) {
    
        self.validate()
            
    }
    
    private func validate() {
        
        if self.emailTextField.text!.isEmpty || !self.emailTextField.text!.trim().isEmail() {
            
            self.showOkAlertWith(title: "Info", message: "Please enter a valid email address.")
            
            return
            
        }
        
        self.resetPassword()
        
    }
    
    private func resetPassword() {
        
        self.isScreenEnabled(enabled: false)

        self.forgotPasswordService.reset(email: self.emailTextField.text!) { errorOptional in
            
            if let _ = errorOptional {
                
                self.showOkAlertWith(title: "Error", message: "User with provided email do not exists in database")
                
            } else {
                
                self.showOkAlertWith(title: "Info", message: "We have sent you an email with instructions on how to recover your password.")
                
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                
                self.isScreenEnabled(enabled: true)

            })

        }
        
    }
    
    fileprivate func isScreenEnabled(enabled: Bool) {
        
        self.sendPasswordButton.isEnabled = enabled
        
        let title = enabled == false ? "" : "Send password"
        
        self.sendPasswordButton.setTitle(title, for: .normal)
        
        self.activityIndicator.isHidden = enabled
        
        self.sendPasswordButton.isUserInteractionEnabled = enabled
        
        self.emailTextField.isEnabled = enabled
        
    }
    
}

extension ForgotPasswordViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
        
    }
    
}
