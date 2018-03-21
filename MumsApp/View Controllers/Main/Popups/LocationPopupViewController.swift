import UIKit
import GoogleMaps
import GooglePlaces

class LocationPopupViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var closeButton: UIButton!
    
    @IBOutlet weak var mapView: GMSMapView!
    
    @IBOutlet weak var enterLocationButton: UIButton!
    
    @IBOutlet weak var doneButton: UIButton!
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    fileprivate var place: GMSPlace?

    private var userDetailsService: UserDetailsService!

    var locationOptional: Location?
    
    func configureWith(userDetailsService: UserDetailsService) {
        
        self.userDetailsService = userDetailsService
        
    }
    
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
        
        self.blockViews(bool: true)

        self.configureData()
        
    }
    
    func configureData() {
        
        guard let location = self.locationOptional else { return }
        
        self.enterLocationButton.setTitle(location.formattedAddress, for: .normal)
        
        self.mapView.addMarker(lat: Double(location.lat!)!, lon: Double(location.lon!)!)
        
        let locationCoordinate = CLLocationCoordinate2D(latitude: Double(location.lat!)!, longitude: Double(location.lon!)!)
        
        let cameraUpdate = GMSCameraUpdate.setTarget(locationCoordinate, zoom: 12)
        
        self.mapView.animate(with: cameraUpdate)
        
    }
    
    @IBAction func enterLocationButtonPressed(_ sender: UIButton) {
        
        let autocompleteController = GMSAutocompleteViewController()
        
        autocompleteController.delegate = self
        
        self.present(autocompleteController, animated: true, completion: nil)
        
    }
    
    @IBAction func doneButtonPressed(_ sender: UIButton) {
    
        guard let id = self.appContext.userId(), let token = self.appContext.token() else { return }
        
        guard let place = self.place else { return }
        
        self.blockViews(bool: false)
        
        self.userDetailsService.updateUserLocation(id: id,
                                                   token: token,
                                                   name: place.name,
                                                   placeID: place.placeID,
                                                   lat: place.coordinate.latitude,
                                                   lon: place.coordinate.longitude,
                                                   formattedAddress: place.formattedAddress ?? "") { errorOptional in
            
            if let error = errorOptional {
                
                self.showOkAlertWith(title: "Error", message: error.localizedDescription)

                self.blockViews(bool: true)

            } else {
                
                self.dismissViewController()

            }
            
        }
        
    }
    
    @IBAction func closeButtonPressed(_ sender: UIButton) {
    
        self.dismissViewController()
    
    }
    
    private func blockViews(bool: Bool) {
        
        self.doneButton.isUserInteractionEnabled = bool

        self.enterLocationButton.isUserInteractionEnabled = bool

        self.loadingIndicator.isHidden = bool
        
        let title = bool ? "Save" : ""
        
        self.doneButton.setTitle(title, for: .normal)
    
    }
    
}

extension LocationPopupViewController: GMSAutocompleteViewControllerDelegate {
    
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
       
        self.place = place
        
        self.enterLocationButton.setTitle(place.formattedAddress, for: .normal)
        
        self.dismiss(animated: true, completion: nil)
    
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {

        print("Error: ", error.localizedDescription)
   
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        
        self.dismiss(animated: true, completion: nil)
    
    }
    
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
    
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
    
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    
    }
    
}
