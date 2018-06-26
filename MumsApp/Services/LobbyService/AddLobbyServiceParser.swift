import Foundation

struct AddLobbyServiceParser: ServiceParser {
    
    func parseDataDictionary(tag: Int, dictionary: Dictionary<String, Any>) -> Bool {
        
        var success: Bool = false
        
        switch tag {
            
        case 0:
            
            success = self.parseStatus(dictionary: dictionary)
            
        default:
            
            return success
            
        }
        
        return success
        
    }
    
    private func parseStatus(dictionary: Dictionary<String, Any>) -> Bool {
        
        var success = false
        
        if let status = dictionary[k_status] as? String, status == k_ok {
            
            success = true
        
        }
        
        return success
        
    }
    
}
