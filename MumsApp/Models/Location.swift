import Foundation

let k_placeID = "placeID"
let k_lat = "lat"
let k_lon = "lon"
let k_formattedAddress = "formattedAddress"

struct Location: Resource {
    
    static let typeName = "Location"
    
    var name: String?
    var placeID: String?
    var lat: String?
    var lon: String?
    var formattedAddress: String?
    
    init(dictionary: StorableDictionary) {
        
        self.name = dictionary[k_name] as? String
        self.placeID = dictionary[k_placeID] as? String
        self.lat = dictionary[k_lat] as? String
        self.lon = dictionary[k_lon] as? String
        self.formattedAddress = dictionary[k_formattedAddress] as? String
        
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
        
        return dictionary
        
    }
    
}

