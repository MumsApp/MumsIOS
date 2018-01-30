import UIKit
import GoogleMaps

class LocationPopupViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var closeButton: UIButton!
    
    @IBOutlet weak var mapView: GMSMapView!
    
    @IBOutlet weak var locationTextField: UITextField!
    
    @IBOutlet weak var doneButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.configureView()
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
     
        self.containerView.layer.cornerRadius = 4

    }

    private func configureView() {
        
        self.titleLabel.font = .regular(size: 20)
        
        self.titleLabel.textColor = .black
        
    }
    
    @IBAction func doneButtonPressed(_ sender: UIButton) {
    
        self.dismissViewController()
        
    }
    
    @IBAction func closeButtonPressed(_ sender: UIButton) {
    
        self.dismissViewController()
    
    }
    
}
