import Foundation

struct AddLobbyServiceParser: ServiceParser {
    
    func parseDataDictionary(tag: Int, dictionary: Dictionary<String, Any>) -> Bool {
        
        var success: Bool = false
        
        switch tag {
            
        case 0:
            
            success = self.parseGetLobbyRooms(dictionary: dictionary)
            
        case 1:
            
            return success
            
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
            
            success = true
        
        }
        
        return success
        
    }
    
}
