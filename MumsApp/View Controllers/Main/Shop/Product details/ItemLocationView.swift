import Foundation
import GoogleMaps

class ItemLocationView: LocationView {

    override func configureView() {
        super.configureView()
        
        self.showSwitch.isHidden = true
        
        self.editButton.isHidden = false
        
        self.configureLocationView()
        
    }
    
    private func configureLocationView() {
        
        self.mapView.addMarker(lat: LONDON_LAT, lon: LONDON_LONG)
        
        let locationCoordinate = CLLocationCoordinate2D(latitude: LONDON_LAT, longitude: LONDON_LONG)
        
        let cameraUpdate = GMSCameraUpdate.setTarget(locationCoordinate, zoom: 12)
        
        self.mapView.animate(with: cameraUpdate)
        
    }
    
    func configureLocationViewWith(lat: Double, lon: Double) {
        
        self.mapView.addMarker(lat: lat, lon: lon)
        
        let locationCoordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        
        let cameraUpdate = GMSCameraUpdate.setTarget(locationCoordinate, zoom: 12)
        
        self.mapView.animate(with: cameraUpdate)
        
    }
    
}
