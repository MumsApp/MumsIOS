import Foundation

struct LobbyServiceParser: ServiceParser {
    
    func parseDataDictionary(tag: Int, dictionary: Dictionary<String, Any>) -> Bool {
        
        var success: Bool = false
        
        switch tag {
            
        case 0:
            
            success = self.parseGetLobbyRooms(dictionary: dictionary)
            
        case 1:
            
            success = self.parseFavouriteLobbyRooms(dictionary: dictionary)
            
        case 2:
            
            return success

        case 3:
            
            return success

        default:
            
            return success
            
        }
        
        return success
        
    }
    
    private func parseGetLobbyRooms(dictionary: Dictionary<String, Any>) -> Bool {
        
        var success = false
        
        if let status = dictionary[k_status] as? String, status == k_ok {
            
            if let _ = dictionary[k_data] as? Array<Dictionary<String, Any>> {
                
                success = true
                
            }
            
        }
        
        return success
        
    }
    
    private func parseFavouriteLobbyRooms(dictionary: Dictionary<String, Any>) -> Bool {
        
        var success = false
        
        if let status = dictionary[k_status] as? String, status == k_ok {
            
            success = true
            
        }
        
        return success
        
    }
    
}
