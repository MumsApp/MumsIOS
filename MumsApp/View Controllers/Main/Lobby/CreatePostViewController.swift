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
    
    fileprivate let imagePicker: UIImagePickerController = UIImagePickerController()

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
        
        self.imagePicker.delegate = self
        
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
    
    @IBAction func addPhotoButtonPressed(_ sender: UIButton) {
    
        self.showPhotoAlert(imagePicker: self.imagePicker)
        
    }
    
    func doneButtonPressed(sender: UIBarButtonItem) {
        
        print("Done")
        
    }
    
}

extension CreatePostViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        self.dismissViewController()
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            self.addPhotoButton.setTitle(nil, for: .normal)
            
            self.addPhotoButton.setImage(pickedImage, for: .normal)
            
        }
        
        self.dismissViewController()
        
    }
    
}
