import Foundation
import MessageKit
import CoreLocation
import UIKit

let dan = Sender(id: "123456", displayName: "Dan Leonard")
let steven = Sender(id: "654321", displayName: "Steven")
let jobs = Sender(id: "000001", displayName: "Steve Jobs")
let cook = Sender(id: "656361", displayName: "Tim Cook")

class SampleData {
    
    static let shared = SampleData()
    
    private init() {}
    
    let messageTextValues = [
        "Ok",
        "k",
        "lol",
        "1-800-555-0000",
        "One Infinite Loop Cupertino, CA 95014 This is some extra text that should not be detected.",
        "This is an example of the date detector 11/11/2017. April 1st is April Fools Day. Next Friday is not Friday the 13th.",
        "https://github.com/SD10",
        "Check out this awesome UI library for Chat",
        "My favorite things in life don’t cost any money. It’s really clear that the most precious resource we all have is time.",
        """
            You know, this iPhone, as a matter of fact, the engine in here is made in America.
            And not only are the engines in here made in America, but engines are made in America and are exported.
            The glass on this phone is made in Kentucky. And so we've been working for years on doing more and more in the United States.
            """,
        """
            Remembering that I'll be dead soon is the most important tool I've ever encountered to help me make the big choices in life.
            Because almost everything - all external expectations, all pride, all fear of embarrassment or failure -
            these things just fall away in the face of death, leaving only what is truly important.
            """,
        "I think if you do something and it turns out pretty good, then you should go do something else wonderful, not dwell on it for too long. Just figure out what’s next.",
        "Price is rarely the most important thing. A cheap product might sell some units. Somebody gets it home and they feel great when they pay the money, but then they get it home and use it and the joy is gone."
    ]

    var senders = [dan, steven, jobs, cook]
    
    var currentSender: Sender {
        return steven
    }
    
    let messageImages: [UIImage] = [#imageLiteral(resourceName: "NiceSelfi"), #imageLiteral(resourceName: "Tim-Cook"), #imageLiteral(resourceName: "Steve-Jobs")]
    
    var now = Date()
    
    let messageTypes = ["Text", "Text", "Text", "Photo", "Video", "Location", "Emoji"]
    
    let attributes = ["Font1", "Font2", "Font3", "Font4", "Color", "Combo"]
    
    let locations: [CLLocation] = [
        CLLocation(latitude: 37.3118, longitude: -122.0312),
        CLLocation(latitude: 33.6318, longitude: -100.0386),
        CLLocation(latitude: 29.3358, longitude: -108.8311),
        CLLocation(latitude: 39.3218, longitude: -127.4312),
        CLLocation(latitude: 35.3218, longitude: -127.4314),
        CLLocation(latitude: 39.3218, longitude: -113.3317)
    ]
    
    let emojis = [
        "👍",
        "👋",
        "👋👋👋",
        "😱😱",
        "🎈",
        "🇧🇷"
    ]
    
    func dateAddingRandomTime() -> Date {
        let randomNumber = Int(arc4random_uniform(UInt32(10)))
        if randomNumber % 2 == 0 {
            let date = Calendar.current.date(byAdding: .hour, value: randomNumber, to: now)!
            now = date
            return date
        } else {
            let randomMinute = Int(arc4random_uniform(UInt32(59)))
            let date = Calendar.current.date(byAdding: .minute, value: randomMinute, to: now)!
            now = date
            return date
        }
    }
    
    func randomMessage() -> Message {
        
        let randomNumberSender = Int(arc4random_uniform(UInt32(senders.count)))
        let randomNumberText = Int(arc4random_uniform(UInt32(messageTextValues.count)))
        let randomNumberImage = Int(arc4random_uniform(UInt32(messageImages.count)))
        let randomMessageType = Int(arc4random_uniform(UInt32(messageTypes.count)))
        let randomNumberLocation = Int(arc4random_uniform(UInt32(locations.count)))
        let randomNumberEmoji = Int(arc4random_uniform(UInt32(emojis.count)))
        let uniqueID = NSUUID().uuidString
        let sender = senders[randomNumberSender]
        let date = dateAddingRandomTime()
        
        switch messageTypes[randomMessageType] {
        case "Text":
            return Message(text: messageTextValues[randomNumberText], sender: sender, messageId: uniqueID, date: date)
        case "Photo":
            let image = messageImages[randomNumberImage]
            return Message(image: image, sender: sender, messageId: uniqueID, date: date)
        case "Video":
            let image = messageImages[randomNumberImage]
            return Message(thumbnail: image, sender: sender, messageId: uniqueID, date: date)
        case "Location":
            return Message(location: locations[randomNumberLocation], sender: sender, messageId: uniqueID, date: date)
        case "Emoji":
            return Message(emoji: emojis[randomNumberEmoji], sender: sender, messageId: uniqueID, date: date)
        default:
            fatalError("Unrecognized mock message type")
        }
    }
    
    func getMessages(count: Int, completion: ([Message]) -> Void) {
        var messages: [Message] = []
        for _ in 0..<count {
            messages.append(randomMessage())
        }
        completion(messages)
    }
    
    func getAvatarFor(sender: Sender) -> Avatar {
        switch sender {
        case dan:
            return Avatar(image: #imageLiteral(resourceName: "NiceSelfi"), initals: "DL")
        case steven:
            return Avatar(initals: "S")
        case jobs:
            return Avatar(image: #imageLiteral(resourceName: "Steve-Jobs"), initals: "SJ")
        case cook:
            return Avatar(image: #imageLiteral(resourceName: "Tim-Cook"))
        default:
            return Avatar()
        }
    }
    
}

