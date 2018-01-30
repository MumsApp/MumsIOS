import UIKit
import GoogleMaps

class LocationPopupViewController: UIViewController {

    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var closeButton: UIButton!
    
    @IBOutlet weak var mapView: GMSMapView!
    
    @IBOutlet weak var locationTextField: UITextField!
    
    @IBOutlet weak var doneButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.configureView()
        
    }

    private func configureView() {
        
        self.contentView.layer.cornerRadius = 4
        
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
