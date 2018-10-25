import Foundation

let k_messages = "messages"

extension MOSocket {
    
    // MARK: - Handlers
    
    // Checking connection
    func handleConnection(completion: @escaping (Bool) -> Void) {
        
        self.socket.on(CONNECT) {data, _ in

            completion(true)

        }
        
    }
    
    // Checking online status
    func handleOnline(completion: @escaping (Any) -> Void) {
        
        self.socket.on(ONLINE) { data, _ in
            
            completion(data)
            
        }
        
    }
    
    // Checking online status
    func handleOffline(completion: @escaping (Any) -> Void) {
        
        self.socket.on(OFFLINE) { data, _ in
            
            completion(data)
            
        }
        
    }
    
    // Checking errors
    func handleErrors(completion: @escaping (Any) -> Void) {
        
        self.socket.on(SOCKET_ERROR) { data, _ in
            
            completion(data)
        
        }
        
    }
    
    // Handle last messages
    func handleLastRoomMessages(completion: @escaping (Array<Message>) -> Void) {
        
        self.socket?.on(LAST_ROOM_MESSAGES) { dataOptional, _ in
            
            print(dataOptional)

            var messagesList: Array<Message> = []
            
            if let data = dataOptional[0] as? Dictionary<String, Any> {
                
                if let messages = data[k_messages] as? Array<Dictionary<String, Any>> {
                    
                    for dictionary in messages {
                        
                        let message = Message(dictionary: dictionary)
                        
                        messagesList.append(message)
                        
                    }
                    
                }
                
            }
        
            completion(messagesList)
            
        }
        
    }
    
    func handleMessage(completion: @escaping (Message?) -> Void) {

        self.socket?.on(MESSAGE, callback: { dataOptional, _ in
            
            print(dataOptional)
            
            var messageOptional: Message?
            
            if let dictionary = dataOptional[0] as? Dictionary<String, Any> {
                
                messageOptional = Message(dictionary: dictionary)

            }
            
            completion(messageOptional)
            
        })
        
    }
    
}
