import UIKit

class OrganisationViewController: UIViewController {
        
    @IBOutlet weak var profileView: OrganisationProfileView!
    
    @IBOutlet weak var locationView: ItemLocationView!
    
    @IBOutlet weak var photosView: OrganisationPhotosView!
    
    @IBOutlet weak var newsView: OrganisationNewsView!
    
    @IBOutlet weak var membersView: OrganisationMembersView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureView()
        
        self.configureNavigationBar()
        
    }
    
    func configureView() {
        
        self.view.backgroundColor = .backgroundWhite
        
    }
    
    private func configureNavigationBar() {
        
        let titleLabel = self.navigationController?.configureNavigationBarWithTitle(title: "Organisation")
        
        self.navigationItem.titleView = titleLabel
        
        self.navigationItem.hidesBackButton = true
        
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "backButtonIcon"), style: .plain, target: self, action: #selector(self.backButtonPressed(sender:)))
        
        self.navigationItem.leftBarButtonItem = backButton
        
    }
    
    func backButtonPressed(sender: UIBarButtonItem) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
}
