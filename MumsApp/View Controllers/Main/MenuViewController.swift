import UIKit

protocol MenuDelegate: class {
    
    func lobbyButtonPressed()
    func profileButtonPressed()
    func chatButtonPressed()
    
}

class MenuViewController: UIViewController {
  
    private weak var delegate: MenuDelegate?
    
    func configureWith(delegate: MenuDelegate?) {
        
        self.delegate = delegate
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    
    }
    
    @IBAction func profileButtonPressed(_ sender: UIButton) {
   
        self.delegate?.profileButtonPressed()
    
    }
    
    @IBAction func lobbyButtonPressed(_ sender: UIButton) {
    
        self.delegate?.lobbyButtonPressed()
    
    }
    
    @IBAction func chatButtonPressed(_ sender: UIButton) {
    
        self.delegate?.chatButtonPressed()
    
    }
    
    @IBAction func findButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func shopButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func offersButtonPressed(_ sender: UIButton) {
    }
    
}
