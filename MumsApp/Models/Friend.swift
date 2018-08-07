import Foundation

let k_friends = "friends"

struct Friend: Resource {
    
    static let typeName = "Friend"
    
    var id: Int?
    
    var name: String?
    
    var surname: String?
    
    var description: String?
   
    var photo: String?
    
    init(dictionary: StorableDictionary) {
        
        self.id = dictionary[k_id] as? Int
        
        self.name = dictionary[k_name] as? String
        
        self.surname = dictionary[k_surname] as? String
        
        self.description = dictionary[k_description] as? String
        
        if let photoDictionary = dictionary[k_photo] as? Dictionary<String, Any> {
            
            self.photo = photoDictionary[k_src] as? String

        }
        
    }
    
    static func fromDictionary(dictionary: Dictionary<String, Any>) -> Friend {
        
        let resource = Friend(dictionary: dictionary)
        
        return resource
        
    }
    
    func toDictionary() -> Dictionary<String, Any> {
        
        var dictionary = Dictionary<String, Any>()
        
        dictionary[k_id] = self.id
        
        dictionary[k_name] = self.name
     
        dictionary[k_surname] = self.surname
        
        dictionary[k_description] = self.description
        
        dictionary[k_photo] = self.photo
        
        return dictionary
        
    }
    
}
