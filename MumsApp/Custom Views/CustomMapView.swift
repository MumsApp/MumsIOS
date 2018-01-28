import Foundation
import GoogleMaps

class CustomMapView: GMSMapView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.configureMap()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.configureMap()
        
    }
    
    private func configureMap() {
        
        do {
            
            if let styleURL = Bundle.main.url(forResource: "GoogleMapsStyle", withExtension: "json") {
                
                self.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
                
            } else {
                
                NSLog("Unable to find style.json")
                
            }
            
        } catch {
            
            NSLog("One or more of the map styles failed to load. \(error)")
            
        }
        
    }
    
}

