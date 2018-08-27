import Foundation

extension MOSocket {
    
    // MARK: - Handlers
    
    // Handle messages
    func handleMessages(completion: @escaping (Array<Message>) -> Void) {
        
        self.socket?.on(LAST_ROOM_MESSAGES) { dataOptional, _ in
            
            print(dataOptional)

            var messages: Array<Message> = []
            
            if let array = dataOptional[0] as? [[String: AnyObject]] {
                
                for dictionary in array {
                    
                    let message = Message(dictionary: dictionary)
                    
                    messages.append(message)
                    
                }
                
            }
        
            completion(messages)
            
        }
        
    }
    
    func handleRoomMessages(completion: @escaping (Array<Message>) -> Void) {
        
        self.socket?.on(MSG) { dataOptional, _ in
            
            print(dataOptional)
            
            var messages: Array<Message> = []
            
            if let array = dataOptional[0] as? [[String: AnyObject]] {
                
                for dictionary in array {
                    
                    let message = Message(dictionary: dictionary)
                    
                    messages.append(message)
                    
                }
                
            }
            
            completion(messages)
            
        }

    }
    
    func handleOnline(completion: @escaping (String) -> Void) {
        
        self.socket?.on(ONLINE, callback: { dataOptional, _ in
            
            print(dataOptional)
            
            completion("ONLINE")
            
        })
        
    }
    
    func handleOffline(completion: @escaping (String) -> Void) {
        
        self.socket?.on(OFFLINE, callback: { dataOptional, _ in
            
            print(dataOptional)
            
            completion("OFFLINE")

        })
        
    }
    
}
