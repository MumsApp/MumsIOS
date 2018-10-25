import Foundation
import SocketIO

// Connect emits

let CONNECT = "connect"

// Start emits

let SOCKET_ERROR = "socketError"
let ONLINE = "online"
let OFFLINE = "offline"
let MESSAGE = "message"
let UPDATE_PUSH_TOKEN = "updatePushToken"

// Rooms emits

let JOIN_ROOM = "joinRoom"
let LAST_ROOM_MESSAGES = "lastRoomMessages"
let MESSAGE_READ = "messageRead"



let k_roomName = "roomName"
let k_jwt = "jwt"
let k_msg = "msg"
let k_deviceType = "deviceType"
let k_deviceToken = "deviceToken"
let k_msgId = "msgId"

class MOSocket: NSObject {
    
    static let sharedInstance: MOSocket = {
        
        let instance = MOSocket()
        
        return instance
        
    }()
    
    override init() {
        super.init()
    }
    
    var socket: SocketIOClient!
    
    func configure() {
        
        self.socket = SocketIOClient(socketURL: URL(string: SOCKET_URL)!, config: [.log(true), .compress])
        
        self.socket.reconnects = true
                        
    }
    
    func establishConnection() {
        
        self.socket.connect(timeoutAfter: 15, withHandler: nil)
        
    }
    
    func closeConnection() {
        
        self.socket?.disconnect()
        
    }
    
    func status() -> Bool {
        
        return self.socket?.status == .connected
        
    }
    
    func addHandlers() {
        
        self.handleOffline { data in
            
            print(data)
            
        }
        
        self.handleOnline { data in

            print(data)

        }
        
        self.handleErrors { data in
            
            print(data)
            
        }
        
        self.handleMessage { data in
            
            print(data)
            
        }
        
    }
    
    // MARK: - Emits
    
    // Setting online status
    func emitOnline(token: String) {
        
        let dictionary = [k_jwt: token]
        
        let json = dictionary.toJSONText()
        
        self.socket.emit(ONLINE, [json])
        
    }
    
    // Joining to group room
    func emitJoinGroupRoom(token: String, roomName: String) {
        
        let dictionary = [k_jwt: token, k_roomName: roomName]

        let json = dictionary.toJSONText()

        self.socket.emit(JOIN_ROOM, [json])
        
    }
    
    // Joining private chat
    func emitJoinPrivateChat(token: String, userIdA: String, userIdB: String) {
        
        let parameters = "private#\(userIdA)-\(userIdB)"

        let dictionary = [k_jwt: token, k_roomName: parameters]
        
        let json = dictionary.toJSONText()

        self.socket.emit(JOIN_ROOM, [json])
        
    }

    // Sending message to room
    func emitSendMessage(token: String, roomName: String, message: String) {
        
        let dictionary = [k_jwt: token, k_roomName: roomName, k_msg: message]

        let json = dictionary.toJSONText()

        self.socket.emit(MESSAGE, [json])
        
    }
    
    // Setting message as read
    func emitSetMessageAsRead(token: String, roomName: String, messageId: String) {
        
        let dictionary = [k_jwt: token, k_roomName: roomName, k_msgId: messageId]
        
        let json = dictionary.toJSONText()
        
        self.socket.emit(MESSAGE_READ, [json])
        
    }
    
    // Updating push token
    func emitUpdatePushToken(token: String, deviceToken: String) {
        
        let dictionary = [k_jwt: token, k_deviceType: "ios", k_deviceToken: deviceToken]
        
        let json = dictionary.toJSONText()
        
        self.socket.emit(UPDATE_PUSH_TOKEN, [json])
        
    }
    
}

extension Dictionary {
    
    func toJSONText() -> String? {
        
        if let theJSONData = try? JSONSerialization.data(
            withJSONObject: self,
            options: []) {
            
            let theJSONText = String(data: theJSONData, encoding: .ascii)
            
            return theJSONText
        
        } else {
            
            return nil
            
        }
        
    }
    
}
