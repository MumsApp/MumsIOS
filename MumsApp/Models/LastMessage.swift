import Foundation
import MessageKit

let k_roomMembers = "roomMembers"
let k_lastMessages = "lastMessages"
let k_lastMessage = "lastMessage"

struct LastMessage {
    
    var roomName: String?
    var roomMembers: Array<Sender>?
    var lastMessage: Message?
    var avatar: String?
    
    init(dictionary: StorableDictionary) {
        
        self.roomMembers = []
        
        self.roomName = dictionary[k_roomName] as? String
        
        let membersArray = dictionary[k_roomMembers] as! Array<Dictionary<String, Any>>
        
        let member = membersArray.first
        
        let authorId = String(member?[k_id] as! Int)
        let authorName = member?[k_name] as! String
        let authorSurname = member?[k_surname] as! String
        
        self.avatar = member?[k_avatar] as? String
        
        self.roomMembers?.append(Sender(id: authorId, displayName: authorName + " " + authorSurname))
        
        if let lastMessage = dictionary[k_lastMessage] as? Dictionary<String, Any> {
            
            self.lastMessage = Message(dictionary: lastMessage)
            
        }
        
    }
    
}
