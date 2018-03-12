import Foundation

let k_description = "description"
let k_location = "location"
let k_children = "children"
let k_photo = "photo"

struct UserDetails: Resource, Storable {
    
    static let typeName = "UserDetails"
    
    var id: String?
    var name: String?
    var surname: String?
    var description: String?
    var location: Location?
    var children: Children?
    var photo: Photo?
    
    init(dictionary: StorableDictionary) {
        
        self.id = dictionary[k_id] as? String
        self.name = dictionary[k_name] as? String
        self.surname = dictionary[k_surname] as? String
        self.description = dictionary[k_description] as? String
        
        if let locationDictionary = dictionary[k_location] as? Dictionary<String, Any> {
            
            self.location = Location.fromDictionary(dictionary: locationDictionary)

        }
        
        if let childrenDictionary = dictionary[k_children] as? Dictionary<String, Any> {
            
            self.children = Children.fromDictionary(dictionary: childrenDictionary)
            
        }
        
        if let photoDictionary = dictionary[k_photo] as? Dictionary<String, Any> {
            
            self.photo = Photo.fromDictionary(dictionary: photoDictionary)

        }
        
    }
    
    static func fromDictionary(dictionary: Dictionary<String, Any>) -> UserDetails {
        
        let resource = UserDetails(dictionary: dictionary)
        
        return resource
        
    }
    
    func toDictionary() -> Dictionary<String, Any> {
        
        var dictionary = Dictionary<String, Any>()
        
        dictionary[k_id] = self.id
        dictionary[k_name] = self.name
        dictionary[k_surname] = self.surname
        dictionary[k_description] = self.description
        dictionary[k_location] = self.location?.toDictionary()
        dictionary[k_children] = self.children?.toDictionary()
        dictionary[k_photo] = self.photo?.toDictionary()
        
        return dictionary
        
    }
    
}

//{
//    "status": "ok",
//    "data"  : {
//        "id"         : 1,
//        "name"       : "john",
//        "surname"    : "doe",
//        "description": "some description details",
//        "location"   : {
//            "name"            : "home",
//            "placeID"         : "8",
//            "lat"             : "10.9990",
//            "lon"             : "11.2340",
//            "formattedAddress": "Some street with details"
//        },
//        "children"   : {
//        "number"      : 4,
//        "ageRangeFrom": 8,
//        "ageRangeTo"  : 9
//        },
//        "photo"      : {
//            "src": "67c2aadef308629c783c8912717330ba.jpeg"
//        }
//    }
//}

