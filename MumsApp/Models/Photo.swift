import Foundation

let k_thumbnail = "thumbnail"
let k_src = "src"

struct Photo: Resource {
    
    static let typeName = "Photo"
    
    var id: String?
    
    var thumbnail: Bool?
    
    var src: String?

    init(dictionary: StorableDictionary) {
        
        self.id = dictionary[k_id] as? String

        self.thumbnail = dictionary[k_thumbnail] as? Bool

        self.src = dictionary[k_src] as? String

    }
    
    static func fromDictionary(dictionary: Dictionary<String, Any>) -> Photo {
        
        let resource = Photo(dictionary: dictionary)
        
        return resource
        
    }
    
    func toDictionary() -> Dictionary<String, Any> {
        
        var dictionary = Dictionary<String, Any>()
        
        dictionary[k_id] = self.id
        
        dictionary[k_thumbnail] = self.thumbnail
        
        dictionary[k_src] = self.src
        
        return dictionary
        
    }
    
}
