import UIKit
import GoogleMaps

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
        
        self.configureLocationView()
        
        self.profileView.organisationDescriptionTextView.isScrollEnabled = false

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.profileView.organisationDescriptionTextView.isScrollEnabled = true
    
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
    
    private func configureLocationView() {
        
        self.locationView.mapView.addMarker(lat: LONDON_LAT, lon: LONDON_LONG)
        
        let locationCoordinate = CLLocationCoordinate2D(latitude: LONDON_LAT, longitude: LONDON_LONG)
        
        let cameraUpdate = GMSCameraUpdate.setTarget(locationCoordinate, zoom: 12)
        
        self.locationView.mapView.animate(with: cameraUpdate)
        
    }
    
    func backButtonPressed(sender: UIBarButtonItem) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
}
