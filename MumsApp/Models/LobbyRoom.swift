import Foundation

let k_title = "title"
let k_img = "img"
let k_isFavourite = "isFavourite"
let k_isOwner = "isOwner"
let k_isJoined = "isJoined"
let k_admin = "admin"

struct LobbyRoom: Resource {
    
    static let typeName = "LobbyRoom"
    
    var id: Int?
    
    var admin: Bool?
    
    var title: String?
    
    var description: String?
        
    var img: String?
        
    var isFavourite: Bool?
    
    var isOwner: Bool?
    
    var isJoined: Bool?
    
    init(dictionary: StorableDictionary) {
        
        self.id = dictionary[k_id] as? Int
        
        self.admin = dictionary[k_admin] as? Bool
        
        self.title = dictionary[k_title] as? String
        
        self.description = dictionary[k_description] as? String
        
        self.img = dictionary[k_img] as? String
        
        self.isFavourite = dictionary[k_isFavourite] as? Bool
        
        self.isOwner = dictionary[k_isOwner] as? Bool
        
        self.isJoined = dictionary[k_isJoined] as? Bool
        
    }
    
    static func fromDictionary(dictionary: Dictionary<String, Any>) -> LobbyRoom {
        
        let resource = LobbyRoom(dictionary: dictionary)
        
        return resource
        
    }
    
    func toDictionary() -> Dictionary<String, Any> {
        
        var dictionary = Dictionary<String, Any>()
        
        dictionary[k_id] = self.id
        
        dictionary[k_admin] = self.admin
        
        dictionary[k_title] = self.title
        
        dictionary[k_description] = self.description
        
        dictionary[k_img] = self.img
        
        dictionary[k_isFavourite] = self.isFavourite
        
        dictionary[k_isOwner] = self.isOwner
        
        dictionary[k_isJoined] = self.isJoined
        
        return dictionary
        
    }
    
}
