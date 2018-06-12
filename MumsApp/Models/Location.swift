import Foundation

let k_placeID = "placeID"
let k_lat = "lat"
let k_lon = "lon"
let k_formattedAddress = "formattedAddress"

struct Location: Resource {
    
    static let typeName = "Location"
    
    var name: String?
    var placeID: String?
    var lat: Double?
    var lon: Double?
    var formattedAddress: String?
    var enabled: Bool?
    
    init(dictionary: StorableDictionary) {
        
        self.name = dictionary[k_name] as? String
        self.placeID = dictionary[k_placeID] as? String
        self.lat = dictionary[k_lat] as? Double
        self.lon = dictionary[k_lon] as? Double
        self.formattedAddress = dictionary[k_formattedAddress] as? String
        self.enabled = dictionary[k_enabled] as? Bool
        
    }
    
    static func fromDictionary(dictionary: Dictionary<String, Any>) -> Location {
        
        let resource = Location(dictionary: dictionary)
        
        return resource
        
    }
    
    func toDictionary() -> Dictionary<String, Any> {
        
        var dictionary = Dictionary<String, Any>()
        
        dictionary[k_name] = self.name
        dictionary[k_placeID] = self.placeID
        dictionary[k_lat] = self.lat
        dictionary[k_lon] = self.lon
        dictionary[k_formattedAddress] = self.formattedAddress
        dictionary[k_enabled] = self.enabled
        
        return dictionary
        
    }
    
}

