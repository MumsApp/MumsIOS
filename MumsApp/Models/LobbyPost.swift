import Foundation

let k_author = "author"
let k_pages = "pages"

struct LobbyPost: Resource {
    
    static let typeName = "LobbyPost"
    
    var id: Int?
    
    var description: String?
    
    var creationDate: Double?
    
    var img: String?
    
    var author: Creator?

    init(dictionary: StorableDictionary) {
        
        self.id = dictionary[k_id] as? Int
        
        self.description = dictionary[k_description] as? String
        
        self.creationDate = dictionary[k_creationDate] as? Double
        
        self.img = dictionary[k_img] as? String
        
        self.author = Creator.fromDictionary(dictionary: dictionary[k_author] as! Dictionary<String, Any>)
        
    }
    
    static func fromDictionary(dictionary: Dictionary<String, Any>) -> LobbyPost {
        
        let resource = LobbyPost(dictionary: dictionary)
        
        return resource
        
    }
    
    func toDictionary() -> Dictionary<String, Any> {
        
        var dictionary = Dictionary<String, Any>()
        
        dictionary[k_id] = self.id
        
        dictionary[k_description] = self.description
        
        dictionary[k_creationDate] = self.creationDate
        
        dictionary[k_img] = self.img
        
        dictionary[k_author] = self.author?.toDictionary()
        
        return dictionary
        
    }
    
}

