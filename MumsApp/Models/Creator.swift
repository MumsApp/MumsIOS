import Foundation

struct Creator: Resource {
    
    static let typeName = "Creator"
    
    var id: Int?
    
    var name: String?
    
    var img: String?
    
    init(dictionary: StorableDictionary) {
        
        self.id = dictionary[k_id] as? Int
        
        self.name = dictionary[k_name] as? String
        
        self.img = dictionary[k_img] as? String
        
    }

    static func fromDictionary(dictionary: Dictionary<String, Any>) -> Creator {
        
        let resource = Creator(dictionary: dictionary)
        
        return resource
        
    }
    
    func toDictionary() -> Dictionary<String, Any> {
        
        var dictionary = Dictionary<String, Any>()
        
        dictionary[k_id] = self.id
        
        dictionary[k_name] = self.name
        
        dictionary[k_img] = self.img
        
        return dictionary
        
    }
    
}
