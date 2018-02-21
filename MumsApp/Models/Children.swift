import Foundation

let k_number = "number"
let k_ageRangeFrom = "ageRangeFrom"
let k_ageRangeTo = "ageRangeTo"

struct Children: Resource {
    
    static let typeName = "Children"
    
    var number: Int?
    var ageRangeFrom: Int?
    var ageRangeTo: Int?
    
    init(dictionary: StorableDictionary) {
        
        self.number = dictionary[k_number] as? Int
        self.ageRangeFrom = dictionary[k_ageRangeFrom] as? Int
        self.ageRangeTo = dictionary[k_ageRangeTo] as? Int
        
    }
    
    static func fromDictionary(dictionary: Dictionary<String, Any>) -> Children {
        
        let resource = Children(dictionary: dictionary)
        
        return resource
        
    }
    
    func toDictionary() -> Dictionary<String, Any> {
        
        var dictionary = Dictionary<String, Any>()
        
        dictionary[k_number] = self.number
        dictionary[k_ageRangeFrom] = self.ageRangeFrom
        dictionary[k_ageRangeTo] = self.ageRangeTo
        
        return dictionary
        
    }
    
}
