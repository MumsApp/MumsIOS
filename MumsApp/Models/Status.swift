import Foundation

struct Status: Resource {
    
    static let typeName = "Status"
    
    var id: Int?
    
    var status: String?

    init(dictionary: StorableDictionary) {
        
        self.id = dictionary[k_id] as? Int
        
        self.status = dictionary[k_status] as? String
        
    }
    
    static func fromDictionary(dictionary: Dictionary<String, Any>) -> Status {
        
        let resource = Status(dictionary: dictionary)
        
        return resource
        
    }
    
    func toDictionary() -> Dictionary<String, Any> {
        
        var dictionary = Dictionary<String, Any>()
        
        dictionary[k_id] = self.id
        
        dictionary[k_status] = self.status
        
        return dictionary
        
    }
    
}
