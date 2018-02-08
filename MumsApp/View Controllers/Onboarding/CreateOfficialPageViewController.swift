import UIKit

class CreateOfficialPageViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
   
    @IBOutlet weak var advertiseButton: UIButton!
    
    @IBOutlet weak var schoolButton: UIButton!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureView()
        
        self.configureNavigationBar()
        
    }
    
    func configureView() {
        
        self.view.backgroundColor = .backgroundWhite
     
        self.titleLabel.font = .regular(size: 33)
        
        self.descriptionLabel.font = .regular(size: 12)
        
        self.descriptionLabel.textColor = .mainDarkGrey

    }
    
    private func configureNavigationBar() {
        
        let titleLabel = self.navigationController?.configureNavigationBarWithTitle(title: "Create Schools & Orgs.")
        
        self.navigationItem.titleView = titleLabel

        self.navigationController?.setNavigationBarHidden(false, animated: false)
       
        self.navigationItem.hidesBackButton = true
        
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "backButtonIcon"), style: .plain, target: self, action: #selector(self.backButtonPressed(sender:)))
        
        self.navigationItem.leftBarButtonItem = backButton
        
    }
    
    func backButtonPressed(sender: UIBarButtonItem) {
        
        self.popToViewController(WelcomeViewController.self)
        
    }
    
    @IBAction func advertiseButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func schoolButtonPressed(_ sender: UIButton) {
    }
    
}
