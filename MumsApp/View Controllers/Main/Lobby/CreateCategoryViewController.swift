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

    }
    
    private func configureView() {
        
        self.categoryContainerView.addShadow()
        
        self.titleContainerView.addShadow()
        
        self.photoContainerView.addShadow()
        
        self.membersContainerView.addShadow()
        
        self.titleLabel.font = .regular(size: 13)
        
        self.titleLabel.textColor = .mainDarkGrey
        
        self.descriptionLabel.font = .regular(size: 13)
        
        self.descriptionLabel.textColor = .mainDarkGrey
        
    }

}
