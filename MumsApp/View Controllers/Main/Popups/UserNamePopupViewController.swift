import UIKit

protocol UserNamePopupDelegate: class {
    
    func saveUserDetails(firstName: String, lastName: String, description: String)
    
}

class UserNamePopupViewController: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var closeButton: UIButton!

    @IBOutlet weak var firstnameTextField: UITextField!
    
    @IBOutlet weak var lastnameTextField: UITextField!
    
    @IBOutlet weak var descriptionTextField: UITextField!

    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!

    private weak var delegate: UserNamePopupDelegate?
    
    func configureWith(delegate: UserNamePopupDelegate?) {
        
        self.delegate = delegate
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureView()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.firstnameTextField.becomeFirstResponder()
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        self.containerView.layer.cornerRadius = 4
        
        self.containerView.backgroundColor = .backgroundWhite
        
    }
    
    private func configureView() {
        
        self.titleLabel.font = .regular(size: 20)
        
        self.firstnameTextField.font = .regular(size: 13)
        
        self.lastnameTextField.font = .regular(size: 13)
        
        self.descriptionTextField.font = .regular(size: 13)

        self.blockView(bool: false)

    }
    
    @IBAction func closeButtonPressed(_ sender: UIButton) {
        
        self.dismissViewController()
        
    }
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {

        self.validate()
                
    }
    
    func validate() {
        
        if self.firstnameTextField.text!.isEmpty || self.lastnameTextField.text!.isEmpty {
            
            self.showOkAlertWith(title: "Info", message: "Please enter your first name and last name.")
            
            return
            
        }
        
        if self.descriptionTextField.text!.isEmpty {
            
            self.showOkAlertWith(title: "Info", message: "Please enter your description.")
            
            return
            
        }
        
        self.blockView(bool: true)
        
        let firstName = self.firstnameTextField.text!.trim()
        
        let lastName = self.lastnameTextField.text!.trim()
        
        let description = self.descriptionTextField.text!.trim()
        
        self.delegate?.saveUserDetails(firstName: firstName, lastName: lastName, description: description)
        
    }
    
    func blockView(bool: Bool) {
        
        self.firstnameTextField.isUserInteractionEnabled = !bool
        
        self.lastnameTextField.isUserInteractionEnabled = !bool
        
        self.descriptionTextField.isUserInteractionEnabled = !bool
        
        self.loadingIndicator.isHidden = !bool
        
        self.saveButton.isUserInteractionEnabled = !bool

        let title = bool == true ? "" : "Save"
        
        self.saveButton.setTitle(title, for: .normal)
        
    }
    
}

extension UserNamePopupViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == self.firstnameTextField {
            
            self.lastnameTextField.becomeFirstResponder()
            
        } else if textField == self.lastnameTextField {
            
            self.descriptionTextField.becomeFirstResponder()
            
        } else {
            
            textField.resignFirstResponder()
            
        }
        
        return true
        
    }
    
}
