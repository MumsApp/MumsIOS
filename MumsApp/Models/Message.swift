import Foundation
import MessageKit
import CoreLocation

let k_sendDate = "sendDate"
let k_message = "message"

struct Message: MessageType {
    
    var messageId: String
    var sender: Sender
    var sentDate: Date
    var data: MessageData
    var avatar: Avatar
    
//    {
//        messages: [
//        {
//        author: 2,
//        id:  10,
//        isRead: null,
//        isSend: 1,
//        message: "siemka",
//        receiver: 0,
//        receiverRoom: "mums_talks",
//        sendDate: "2018-08-21T21:35:13.000Z"
//        }
//        ],
//        roomName: "mums_talks"
//    }
    
    init(dictionary: StorableDictionary) {
        
        self.messageId = dictionary[k_id] as! String
        
        self.sender = Sender(id: dictionary[k_author] as! String, displayName: "Sender")
     
        let dateFormatter = DateFormatter()

        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

        dateFormatter.locale = Locale(identifier: "en_US_POSIX")

        let date = dateFormatter.date(from: dictionary[k_sendDate] as! String)!

        self.sentDate = date
        
        self.data = MessageData.text(dictionary[k_message] as! String)
        
        self.avatar = Avatar(image: nil, initals: "S")
        
    }
    
//    init(data: MessageData, sender: Sender, messageId: String, date: Date, avatar: Avatar) {
//        self.data = data
//        self.sender = sender
//        self.messageId = messageId
//        self.sentDate = date
//        self.avatar = avatar
//    }
//    
//    init(text: String, sender: Sender, messageId: String, date: Date, avatar: Avatar) {
//        self.init(data: .text(text), sender: sender, messageId: messageId, date: date, avatar: avatar)
//    }
//    
//    init(attributedText: NSAttributedString, sender: Sender, messageId: String, date: Date, avatar: Avatar) {
//        self.init(data: .attributedText(attributedText), sender: sender, messageId: messageId, date: date, avatar: avatar)
//    }
//    
//    init(image: UIImage, sender: Sender, messageId: String, date: Date, avatar: Avatar) {
//        self.init(data: .photo(image), sender: sender, messageId: messageId, date: date, avatar: avatar)
//    }
//    
//    init(thumbnail: UIImage, sender: Sender, messageId: String, date: Date, avatar: Avatar) {
//        let url = URL(fileURLWithPath: "")
//        self.init(data: .video(file: url, thumbnail: thumbnail), sender: sender, messageId: messageId, date: date, avatar: avatar)
//    }
//    
//    init(location: CLLocation, sender: Sender, messageId: String, date: Date, avatar: Avatar) {
//        self.init(data: .location(location), sender: sender, messageId: messageId, date: date, avatar: avatar)
//    }
//    
//    init(emoji: String, sender: Sender, messageId: String, date: Date, avatar: Avatar) {
//        self.init(data: .emoji(emoji), sender: sender, messageId: messageId, date: date, avatar: avatar)
//    }
    
}
