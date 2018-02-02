import UIKit

class MenuViewController: UIViewController {

    @IBOutlet weak var closeButton: UIButton!
  
    override func viewDidLoad() {
        super.viewDidLoad()

    
    }

    @IBAction func closeButtonPressed(_ sender: UIButton) {
    
        self.dismissViewController()
    
    }
    
}
