import Foundation

let k_subCategories = "subCategories"

struct ShopCategory: Resource {
    
    static let typeName = "ShopCategory"
    
    var id: Int?
    
    var name: String?
    
    var subCategories: Array<ShopSubCategory> = []
    
    init(dictionary: StorableDictionary) {
        
        self.id = dictionary[k_id] as? Int
        
        self.name = dictionary[k_name] as? String
        
        if let shopSubCategories = dictionary[k_subCategories] as? Array<Dictionary<String, Any>> {
            
            self.subCategories = []
            
            for shopSubCategory in shopSubCategories {
                
                self.subCategories.append(ShopSubCategory.fromDictionary(dictionary: shopSubCategory))
                
            }
            
        }
    }
    
    static func fromDictionary(dictionary: Dictionary<String, Any>) -> ShopCategory {
        
        let resource = ShopCategory(dictionary: dictionary)
        
        return resource
        
    }
    
    func toDictionary() -> Dictionary<String, Any> {
        
        var dictionary = Dictionary<String, Any>()
        
        dictionary[k_id] = self.id
        
        dictionary[k_name] = self.name
        
        var subCategories: Array<Dictionary<String, Any>> = []
        
        for subCategory in self.subCategories {
            
            subCategories.append(subCategory.toDictionary())
            
        }
        
        dictionary[k_subCategories] = subCategories
        
    
        return dictionary
        
    }
    
}

