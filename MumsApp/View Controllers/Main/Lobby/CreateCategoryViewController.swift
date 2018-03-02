import UIKit

class CreateCategoryViewController: UIViewController {

    @IBOutlet weak var categoryContainerView: UIView!
    
    @IBOutlet weak var publicCategoryLabel: UILabel!
    
    @IBOutlet weak var publicCategorySwitch: UISwitch!
    
    @IBOutlet weak var titleContainerView: UIView!
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var descriptionContainerView: UIView!
    
    @IBOutlet weak var descriptionTextView: UITextView!
    
    @IBOutlet weak var photoContainerView: UIView!
   
    @IBOutlet weak var addPhotoButton: UIButton!
    
    @IBOutlet weak var membersContainerView: UIView!
    
    @IBOutlet weak var addMembersButton: UIButton!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var coverPhotoLabel: UILabel!
    
    @IBOutlet weak var membersLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.configureView()

        self.configureNavigationBar()
        
    }
    
    private func configureView() {
        
        self.categoryContainerView.addShadow()
        
        self.titleContainerView.addShadow()
        
        self.photoContainerView.addShadow()
        
        self.membersContainerView.addShadow()
        
        self.descriptionContainerView.addShadow()
        
        self.titleLabel.font = .regular(size: 13)
        
        self.titleLabel.textColor = .mainDarkGrey
        
        self.descriptionLabel.font = .regular(size: 13)
        
        self.descriptionLabel.textColor = .mainDarkGrey
        
        self.coverPhotoLabel.font = .regular(size: 13)
        
        self.coverPhotoLabel.textColor = .mainDarkGrey
        
        self.membersLabel.font = .regular(size: 13)
        
        self.membersLabel.textColor = .mainDarkGrey
    
        self.publicCategoryLabel.font = .regular(size: 17)
        
        self.publicCategoryLabel.textColor = .black
    
        self.titleTextField.font = .regular(size: 17)
        
        self.titleTextField.textColor = .black
        
        self.descriptionTextView.font = .regular(size: 17)
        
        self.descriptionTextView.textColor = .black
        
        self.addPhotoButton.titleLabel?.font = .regular(size: 17)
        
        self.addMembersButton.titleLabel?.font = .regular(size: 17)
        
    }
    
    private func configureNavigationBar() {
        
        let titleLabel = self.navigationController?.configureNavigationBarWithTitle(title: "Create Category")
        
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
        
        
    }
    
    @IBAction func addMembersButtonPressed(_ sender: UIButton) {
    
        self.showAddMembersViewController()
    
    }
    
    private func showAddMembersViewController() {
        
        let factory = SecondaryViewControllerFactory.viewControllerFactory()
        
        let controller = factory.addMembersViewController()
                self.navigationController?.pushViewController(controller, animated: true)
        
    }

    
}
