import UIKit

class ForgotPasswordViewController: UIViewController {

    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var sendPasswordButton: UIButton!

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

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
    }
    
}

extension ForgotPasswordViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
        
    }
    
}
