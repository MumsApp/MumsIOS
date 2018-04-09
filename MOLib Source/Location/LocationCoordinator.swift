import Foundation
import UIKit
import MapKit

public protocol LocationCoordinatorDelegate {
    
    func locationCoordinatorDidFindCurrentLocation(_ coordinator: LocationCoordinator, location: MOGeoLocation)

    func locationCoordinatorDidFail(_ coordinator: LocationCoordinator, alertController: UIViewController)
    
}

@objc open class LocationCoordinator: NSObject, LocationManagerDelegate {
    
    open var delegate: LocationCoordinatorDelegate?
    
    fileprivate var preferredLocation: MOGeoLocation
    
    fileprivate var actualLocation: MOGeoLocation
    
    fileprivate var locationManager: LocationManager
    
    fileprivate var userDefaults: MOUserDefaults
    
    fileprivate var alertController: UIAlertController!
    
    public init(locationManager: LocationManager, userDefaults: MOUserDefaults) {
        
        self.locationManager = locationManager
      
        self.userDefaults = userDefaults
        
        let dictionaryOptional = userDefaults.dictionaryForKey(kLocationDictionaryUserDefaultsKey)
        
        if let dictionary = dictionaryOptional {
            
            self.preferredLocation = MOGeoLocation(dictionary: dictionary as Dictionary<String, AnyObject>)
        
        } else {
            
            self.preferredLocation = MOGeoLocation(name: "Unknown Location", coords: CLLocationCoordinate2DMake(LONDON_LAT, LONDON_LONG))
       
        }
        
        self.actualLocation = self.preferredLocation
        
        super.init()

        self.locationManager.delegate = self
    
    }
    
    open func currentLocation() -> MOGeoLocation {
        
        return actualLocation
    
    }
    
    open func usersPreferredLocation() -> MOGeoLocation {
        
        return self.preferredLocation
    
    }
    
    open func setUsersPreferredLocation(_ location: MOGeoLocation) {
        
        self.preferredLocation = location
    
    }
    
    open func requestCurrentLocation() {
        
        self.locationManager.requestCurrentLocation()
    
    }
    
    open func setCurrentLocation(_ geoLocation: MOGeoLocation) {
        
        let locationDictionary = geoLocation.toDictionary()
        
        self.userDefaults.setDictionary(locationDictionary, forKey: kLocationDictionaryUserDefaultsKey)
        
        self.actualLocation.locationName = geoLocation.locationName
      
        self.actualLocation.geoPoint = geoLocation.geoPoint
        
        self.delegate?.locationCoordinatorDidFindCurrentLocation(self, location: self.actualLocation)
    
    }
    
    //mark: - Location Manager Delegates
    
    open func locationFound(_ location: CLLocation) {
        
        let geoLocation = MOGeoLocation(name: NSLocalizedString("Current location", comment: ""), coords: location.coordinate)

        self.setCurrentLocation(geoLocation)
  
    }
    
    open func locationServicesDisabled() {
        
        let title = NSLocalizedString("Location Services Disabled", comment: "")
    
        let message = NSLocalizedString("You currently have all location services for this app disabled. You will need to enable them to get your current location", comment: "")
        
       self.showFailedAlert(title, message: message)
  
    }
    
    open func locationServiceFailed(_ error: Error) {
        
        let title = NSLocalizedString("Location Services Error", comment: "")
 
        let message = "We are not able to check your location. Please check your location services settings."
        
        self.showFailedAlert(title, message: message)

    }
    
    func showFailedAlert(_ title: String, message: String) {
        
        self.alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        self.alertController.addAction(UIAlertAction(title: "Open settings", style: .default, handler: { action in
            
            if let url = URL(string: "App-Prefs:root=Privacy&path=LOCATION") {
                
                UIApplication.shared.open(url, completionHandler: .none)
            
            }
            
        }))
        
        self.alertController.addAction(UIAlertAction(title: "Dismiss", style: .destructive))
        
        self.delegate?.locationCoordinatorDidFail(self, alertController: self.alertController)

    }
    
    open func geoCodeFound(_ placeMark: CLPlacemark) {
        
    }
    
    open func geoCodeFailed(_ error: Error) {
        
    }
    
    open func distanceFromCurrentLocationToLocation(_ coordinate: CLLocationCoordinate2D) -> CLLocationDistance {
        
        var distance: CLLocationDistance = 0
        
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        
        distance = distanceFrom(self.currentLocation().location.coordinate, to: location.coordinate)
      
        return distance / 1000
        
    }
    
    fileprivate func distanceFrom(_ locationX: CLLocationCoordinate2D, to locationY:CLLocationCoordinate2D) -> CLLocationDistance {
        
        let start = MKMapPointForCoordinate(locationX)
        
        let finish = MKMapPointForCoordinate(locationY)
        
        return MKMetersBetweenMapPoints(start, finish) * 1000
    
    }
    
}
