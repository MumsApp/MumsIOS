import UIKit

class CreatePostViewController: UIViewController {
    
    @IBOutlet weak var titleContainerView: UIView!
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var descriptionContainerView: UIView!
    
    @IBOutlet weak var descriptionTextView: UITextView!
    
    @IBOutlet weak var photoContainerView: UIView!
    
    @IBOutlet weak var addPhotoButton: UIButton!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var postLabel: UILabel!
    
    @IBOutlet weak var photoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureView()
        
        self.configureNavigationBar()
        
    }
    
    private func configureView() {
        
        self.titleContainerView.addShadow()
        
        self.photoContainerView.addShadow()
        
        self.descriptionContainerView.addShadow()
        
        self.titleLabel.font = .regular(size: 13)
        
        self.titleLabel.textColor = .mainDarkGrey
        
        self.postLabel.font = .regular(size: 13)
        
        self.postLabel.textColor = .mainDarkGrey
        
        self.photoLabel.font = .regular(size: 13)
        
        self.photoLabel.textColor = .mainDarkGrey
    
        self.titleTextField.font = .regular(size: 17)
        
        self.titleTextField.textColor = .black
        
        self.descriptionTextView.font = .regular(size: 17)
        
        self.descriptionTextView.textColor = .black
        
        self.addPhotoButton.titleLabel?.font = .regular(size: 17)
        
    }
    
    private func configureNavigationBar() {
        
        let titleLabel = self.navigationController?.configureNavigationBarWithTitle(title: "Create Post")
        
        self.navigationItem.titleView = titleLabel
        
        self.navigationItem.hidesBackButton = true
        
        let rightButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.doneButtonPressed(sender:)))
        
        rightButton.tintColor = .mainGreen
        
        self.navigationItem.rightBarButtonItem = rightButton
        
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "backButtonIcon"), style: .plain, target: self, action: #selector(self.backButtonPressed(sender:)))
        
        self.navigationItem.leftBarButtonItem = backButton
        
    }
    
    func backButtonPressed(sender: UIBarButtonItem) {
        
        self.navigationController?.popViewController(animated: true)
        
        
    }
    
    func doneButtonPressed(sender: UIBarButtonItem) {
        
        print("Done")
        
    }
    
}

