import Foundation

let k_description = "description"
let k_location = "location"
let k_children = "children"
let k_photo = "photo"
let k_isFriend = "isFriend"

struct UserDetails: Resource, Storable {
    
    static let typeName = "UserDetails"
    
    var id: String?
    var name: String?
    var surname: String?
    var description: String?
    var location: Location?
    var children: Array<Children>?
    var photo: Photo?
    var isFriend: Bool?
    
    init(dictionary: StorableDictionary) {
        
        self.id = dictionary[k_id] as? String
        self.name = dictionary[k_name] as? String
        self.surname = dictionary[k_surname] as? String
        self.description = dictionary[k_description] as? String
        self.isFriend = dictionary[k_isFriend] as? Bool
        
        if let locationDictionary = dictionary[k_location] as? Dictionary<String, Any> {
            
            self.location = Location.fromDictionary(dictionary: locationDictionary)

        }
        
        if let childrenArray = dictionary[k_children] as? Array<Dictionary<String, Any>> {
        
            self.children = []
            
            for childrenDictionary in childrenArray {
                
                self.children?.append(Children.fromDictionary(dictionary: childrenDictionary))

            }
            
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
        dictionary[k_isFriend] = self.isFriend
        dictionary[k_photo] = self.photo?.toDictionary()
        
        var childrenArray: Array<Dictionary<String, Any>> = []
        
        for children in self.children! {
            
            childrenArray.append(children.toDictionary())
            
        }
        
        dictionary[k_children] = childrenArray
        
        return dictionary
        
    }
    
}
