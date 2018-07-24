import Foundation

let k_creator = "creator"
let k_creationDate = "creationDate"

struct LobbyTopic: Resource {
    
    static let typeName = "LobbyTopic"
    
    var id: Int?
    
    var title: String?
    
    var description: String?
    
    var creationDate: Double?
    
    var img: String?
    
    var creator: Creator?
    
    var pages: Int?
    
    init(dictionary: StorableDictionary) {
        
        self.id = dictionary[k_id] as? Int
        
        self.title = dictionary[k_title] as? String
        
        self.description = dictionary[k_description] as? String
        
        self.creationDate = dictionary[k_creationDate] as? Double
        
        self.img = dictionary[k_img] as? String
        
        self.creator = Creator.fromDictionary(dictionary: dictionary[k_creator] as! Dictionary<String, Any>)
        
        self.pages = dictionary[k_pages] as? Int

    }
    
    static func fromDictionary(dictionary: Dictionary<String, Any>) -> LobbyTopic {
        
        let resource = LobbyTopic(dictionary: dictionary)
        
        return resource
        
    }
    
    func toDictionary() -> Dictionary<String, Any> {
        
        var dictionary = Dictionary<String, Any>()
        
        dictionary[k_id] = self.id
        
        dictionary[k_title] = self.title
        
        dictionary[k_description] = self.description
        
        dictionary[k_creationDate] = self.creationDate
        
        dictionary[k_img] = self.img
        
        dictionary[k_creator] = self.creator?.toDictionary()
        
        dictionary[k_pages] = self.pages
        
        return dictionary
        
    }
    
}
