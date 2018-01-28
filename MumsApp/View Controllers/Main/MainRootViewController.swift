import UIKit

class MainRootViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.showProfileViewController()
        
    }

    private func showProfileViewController() {
        
        let factory = SecondaryViewControllerFactory.viewControllerFactory()
        
        let controller = factory.profileViewController()
        
        self.navigationController?.pushViewController(controller, animated: false)
     
    }
    
}
