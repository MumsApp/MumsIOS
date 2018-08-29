import Foundation
import SocketIO

let JOIN_ROOM = "joinRoom"
let MSG = "msg"
let ONLINE = "online"
let OFFLINE = "offline"
let LAST_ROOM_MESSAGES = "lastRoomMessages"

let k_roomName = "roomName"
let k_jwt = "jwt"
let k_msg = "msg"

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
                
        self.establishConnection()
        
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
        
        self.handleMessages { messages in
            
            print(messages)
            
        }
        
        self.handleRoomMessages { messages in
            
            print(messages)
            
        }
        
        self.handleOnline { _ in
            
            print("Here")
            
        }
        
    }
    
    // MARK: - Emits
    
    func emitJoinPrivateRoom(userIdA: String, userIdB: String) {
        
        let parameters = "private#\(userIdA)-\(userIdB)"
        
        self.socket.emit(JOIN_ROOM, parameters)
        
    }
    
    // OK
    func emitJoinGroupRoom(roomId: String) {
        
        self.socket.emit(JOIN_ROOM, roomId)

    }
    
    func emitSendMessage(roomName: String, token: String, message: String) {
        
        self.socket.emit(MSG, roomName, token, message)

    }
    
    func emitOnline(token: String) {
        
        let parameters = [k_jwt: token]
        
        self.socket.emit(ONLINE, parameters)
        
    }
    
}
