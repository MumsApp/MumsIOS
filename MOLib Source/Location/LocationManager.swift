import Foundation
import CoreLocation
import MapKit

let kLocationErrorCode = 901

@objc public protocol LocationManagerDelegate: NSObjectProtocol {

    func locationServicesDisabled()

    func locationServiceFailed(_ error: Error)

    func locationFound(_ location: CLLocation)
 
    func geoCodeFound(_ placeMark: CLPlacemark)
    
    func geoCodeFailed(_ error: Error)
}

@objc open class LocationManager: NSObject, CLLocationManagerDelegate {
    
    weak var delegate: LocationManagerDelegate?
    
    fileprivate var manager: CLLocationManager
   
    fileprivate var reverseGeocoder:  CLGeocoder?

    fileprivate var currentLocation: CLLocation?

    override public init() {
        
        self.manager = CLLocationManager()
            
        self.manager.desiredAccuracy = kCLLocationAccuracyBest
        
        self.manager.allowsBackgroundLocationUpdates = true
        
//        self.manager.distanceFilter = 1000 // meters
        
        super.init()
   
    }
    
    open func requestCurrentLocation() {
    
        self.manager.delegate = self

        let authStatus = CLLocationManager.authorizationStatus()
    
        self.handleAuthorisationForState(authStatus)
    
    }
    
    private func handleAuthorisationForState(_ authStatus: CLAuthorizationStatus) {
        
        switch authStatus {
            
        case .notDetermined:
            
            if self.manager.responds(to: #selector(CLLocationManager.requestWhenInUseAuthorization)) {
                
                self.manager.requestAlwaysAuthorization()
           
            } else {
                
                self.manager.startUpdatingLocation()
           
            }
            
            break
        
        case .authorizedAlways, .authorizedWhenInUse:
            
            self.manager.startUpdatingLocation()
            
        case .denied:
            
            let userInfo = [NSLocalizedDescriptionKey: "You currently have all location services for this app disabled. You will need to enable them to get your current location"]
            
            let error = NSError(domain: "LocationManager", code: kLocationErrorCode, userInfo: userInfo)
            
            self.delegate?.locationServiceFailed(error)

        default:
            
            break
            
        }

    }
    
    //MARK: - CLLocationManager Delegate Methods
  
    open func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    
        self.handleAuthorisationForState(status)
    
    }

    open func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
 
        if let location = locations.last {

            let eventDate = location.timestamp
    
            let howRecent = eventDate.timeIntervalSinceNow
    
            if (abs(howRecent) < 15.0 || self.currentLocation == nil) {

                self.currentLocation = location
            
            }
    
            self.delegate?.locationFound(currentLocation!)
            
        } else {
            
            let userInfo = [NSLocalizedDescriptionKey: "Unable to determine location"]
            
            let error = NSError(domain: "LocationManager", code: kLocationErrorCode, userInfo: userInfo)
            
            self.delegate?.locationServiceFailed(error)
        
        }
    }
    
    open func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        let clErrorCode = CLError.Code(rawValue: error._code)

        switch (clErrorCode!) {
        
        case .denied:
    
            self.delegate?.locationServicesDisabled()
            
            break
    
        default:
    
            self.delegate?.locationServiceFailed(error as Error)
        
            break
    
        }
    
        manager.stopMonitoringSignificantLocationChanges()
    
    }
    
}
