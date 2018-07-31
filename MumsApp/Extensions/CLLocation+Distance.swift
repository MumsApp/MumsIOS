import Foundation
import CoreLocation

func distanceFrom(userLocation: CLLocation, productLat: String, productLon: String) -> String {
        
    let productLocation = CLLocation(latitude: Double(productLat)!, longitude: Double(productLon)!)
    
    let distance = Int(userLocation.distance(from: productLocation) * MILES)
    
    let distanceText = distance == 1 ? " mile" : " miles"
    
    return String(distance) + distanceText
    
}
