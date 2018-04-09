import Foundation
import CoreLocation

public let kLocationDictionaryUserDefaultsKey = "selectedLocation"
public let kLocationDictionaryNameKey = "name"
public let kLocationDictionaryLatitudeey = "lat"
public let kLocationDictionaryLongitudeKey = "lon"

@objc open class MOGeoLocation: NSObject {
    
    open var locationName: String
    open var geoPoint: CLLocationCoordinate2D

    open var location: CLLocation {
        
        get { return CLLocation(latitude: geoPoint.latitude, longitude: geoPoint.longitude) }
    
    }
    
    public convenience init(dictionary: Dictionary<String, AnyObject>) {
    
        let name = dictionary[kLocationDictionaryNameKey] as? String
        
        let latitudeNumber = dictionary[kLocationDictionaryLatitudeey] as? Double
    
        let longitudeNumber = dictionary[kLocationDictionaryLongitudeKey] as? Double
    
        let coordinates = CLLocationCoordinate2DMake(latitudeNumber!, longitudeNumber!)
    
        self.init(name: name!, coords:coordinates)
   
    }
    
    public init(name: String, coords:CLLocationCoordinate2D) {
    
        locationName = name
    
        geoPoint = coords
 
    }
    
    open func toDictionary() -> Dictionary<String, AnyObject> {
    
        let dictonary: Dictionary<String, AnyObject>  = [ kLocationDictionaryNameKey: self.locationName as AnyObject,
                        kLocationDictionaryLatitudeey: self.geoPoint.latitude as AnyObject,
                        kLocationDictionaryLongitudeKey: self.geoPoint.longitude as AnyObject]
    
    
        return dictonary
    
    }
    
}
