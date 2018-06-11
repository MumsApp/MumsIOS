import Foundation

let k_age = "age"
let k_ageUnit = "ageUnit"
let k_sex = "sex"

struct Children: Resource {
    
    static let typeName = "Children"
    
    var id: Int?
    var age: Int?
    var ageUnit: Int?
    var sex: Int?
    
    init(dictionary: StorableDictionary) {
        
        self.id = dictionary[k_id] as? Int
        self.age = dictionary[k_age] as? Int
        self.ageUnit = dictionary[k_ageUnit] as? Int
        self.sex = dictionary[k_sex] as? Int
        
    }
    
    static func fromDictionary(dictionary: Dictionary<String, Any>) -> Children {
        
        let resource = Children(dictionary: dictionary)
        
        return resource
        
    }
    
    func toDictionary() -> Dictionary<String, Any> {
        
        var dictionary = Dictionary<String, Any>()
        
        dictionary[k_id] = self.id
        dictionary[k_age] = self.age
        dictionary[k_ageUnit] = self.ageUnit
        dictionary[k_sex] = self.sex
        
        return dictionary
        
    }
    
}
