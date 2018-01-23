import Foundation

let k_id = "id"

struct User: Resource, Storable {
    
    static let typeName = "User"
    
    var id: String?
    
    init(dictionary: StorableDictionary) {
        
        self.id = dictionary[k_id] as? String
        
    }
    
    static func fromDictionary(dictionary: Dictionary<String, Any>) -> User {
        
        let resource = User(dictionary: dictionary)
        
        return resource
        
    }
    
    func toDictionary() -> Dictionary<String, Any> {
        
        var dictionary = Dictionary<String, Any>()
        
        dictionary[k_id] = self.id
    
        return dictionary
        
    }
    
}

