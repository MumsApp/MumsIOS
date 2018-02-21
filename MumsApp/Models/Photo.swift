import Foundation

let k_src = "src"

struct Photo: Resource {
    
    static let typeName = "Photo"
    
    var src: String?
    
    init(dictionary: StorableDictionary) {
        
        self.src = dictionary[k_src] as? String
       
    }
    
    static func fromDictionary(dictionary: Dictionary<String, Any>) -> Photo {
        
        let resource = Photo(dictionary: dictionary)
        
        return resource
        
    }
    
    func toDictionary() -> Dictionary<String, Any> {
        
        var dictionary = Dictionary<String, Any>()
        
        dictionary[k_src] = self.src
        
        return dictionary
        
    }
    
}
