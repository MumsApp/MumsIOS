import UIKit

class CreateOfficialPageViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
   
    @IBOutlet weak var advertiseButton: UIButton!
    
    @IBOutlet weak var schoolButton: UIButton!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureNavigationBar()
        
    }
    
    private func configureNavigationBar() {
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
    }
    
    @IBAction func advertiseButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func schoolButtonPressed(_ sender: UIButton) {
    }
    
}
