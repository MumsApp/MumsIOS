import Foundation

struct ShopSubCategory: Resource {
    
    static let typeName = "ShopSubCategory"
    
    var id: Int?
    
    var name: String?
    
    init(dictionary: StorableDictionary) {
    
        self.id = dictionary[k_id] as? Int
    
        self.name = dictionary[k_name] as? String
    
    }
    
    static func fromDictionary(dictionary: Dictionary<String, Any>) -> ShopSubCategory {
    
        let resource = ShopSubCategory(dictionary: dictionary)
    
        return resource
    
    }
    
    func toDictionary() -> Dictionary<String, Any> {
    
        var dictionary = Dictionary<String, Any>()
    
        dictionary[k_id] = self.id
    
        dictionary[k_name] = self.name
    
        return dictionary
        
    }
    
}
