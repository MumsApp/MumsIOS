import Foundation
import GoogleMaps

extension GMSMapView {
    
    func addMarker(lat: Double, lon: Double) {
        
        let position = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        
        let marker = GMSMarker(position: position)
        
        marker.icon = #imageLiteral(resourceName: "pinIcon")
        
        marker.map = self
        
    }
    
}
