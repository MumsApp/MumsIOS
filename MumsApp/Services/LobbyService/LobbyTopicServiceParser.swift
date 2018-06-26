import Foundation

struct LobbyTopicServiceParser: ServiceParser {
    
    func parseDataDictionary(tag: Int, dictionary: Dictionary<String, Any>) -> Bool {
        
        var success: Bool = false
        
        switch tag {
            
        case 0:
            
            success = self.parseStatus(dictionary: dictionary)
            
        case 1:
            
            success = self.parseData(dictionary: dictionary)

        default:
            
            return success
            
        }
        
        return success
        
    }

    
    private func parseStatus(dictionary: Dictionary<String, Any>) -> Bool {
        
        var success = false
        
        if let status = dictionary[k_status] as? String, status == k_ok {
            
            if let _ = dictionary[k_data] as? Array<Dictionary<String, Any>> {
                
                success = true
                
            }
            
        }
        
        return success
        
    }
    
    
    private func parseData(dictionary: Dictionary<String, Any>) -> Bool {
        
        var success = false
        
        if let status = dictionary[k_status] as? String, status == k_ok {
            
            success = true
            
        }
        
        return success
        
    }

}
