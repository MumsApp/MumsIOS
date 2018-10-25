import Foundation
import MessageKit

let k_sendDate = "sendDate"
let k_message = "message"
let k_isSend = "isSend"
let k_isRead = "isRead"
let k_receiver = "receiver"
let k_avatar = "avatar"

struct Message: MessageType {
    
    var messageId: String
    var sender: Sender
    var sentDate: Date
    var data: MessageData
    var avatar: Avatar
    
    var roomName: String?
    var isSend: Bool?
    var isRead: Bool?
    var receiver: String?
    var avatarSrc: String?
    var msg: String?
    
    init(dictionary: StorableDictionary) {
        
        self.messageId = String(dictionary[k_id] as! Int)
        
        let authorOptional = dictionary[k_author] as! Dictionary<String, Any>
        
        let authorId = String(authorOptional[k_id] as! Int)
        let authorName = authorOptional[k_name] as! String
        let authorSurname = authorOptional[k_surname] as! String
        
        self.sender = Sender(id: authorId, displayName: authorName + " " + authorSurname)
        
        self.avatar = Avatar(image: nil, initals: String(authorName.first!))
       
        let date = (dictionary[k_sendDate] as! String).dateFromISO8601!
        
        self.sentDate = date
        
        self.data = MessageData.text(dictionary[k_msg] as! String)
        
        self.msg = dictionary[k_msg] as? String
        
        self.roomName = dictionary[k_roomName] as? String

        self.isSend = dictionary[k_isSend] as? Bool
        
        self.isRead = dictionary[k_isRead] as? Bool
        
        self.receiver = dictionary[k_receiver] as? String
     
        self.avatarSrc = authorOptional[k_avatar] as? String

    }

}
