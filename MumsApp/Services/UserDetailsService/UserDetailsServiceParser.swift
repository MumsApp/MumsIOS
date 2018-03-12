import Foundation

let k_data = "data"

struct UserDetailsServiceParser: ServiceParser {
      
    func parseDataDictionary(tag: Int, dictionary: Dictionary<String, Any>) -> Bool {
        
        var success: Bool = false
        
        switch tag {
            
        case 0:
            
            success = self.parseUserDetails(dictionary: dictionary)
            
        case 1:
            
            success = self.parseUserName(dictionary: dictionary)
            
        case 2:
            
            success = self.parseUserChildren(dictionary: dictionary)
            
        case 3:
            
            success = self.parseUserLocation(dictionary: dictionary)
            
        default:
            
            return success
            
        }
        
        return success
        
    }
    
    private func parseUserDetails(dictionary: Dictionary<String, Any>) -> Bool {
        
        var success = false
        
        if let status = dictionary[k_status] as? String, status == k_ok {
            
            if let _ = dictionary[k_data] as? Dictionary<String, Any> {
                
                success = true
                
            }
            
        }
        
        return success
        
    }
    
    private func parseUserName(dictionary: Dictionary<String, Any>) -> Bool {
        
        var success = false

        if let status = dictionary[k_status] as? String, status == k_ok {
            
            success = true
            
        }
        
        return success
        
    }
    
    private func parseUserChildren(dictionary: Dictionary<String, Any>) -> Bool {
        
        var success = false

        if let status = dictionary[k_status] as? String, status == k_ok {
            
            success = true
            
        }
        
        return success
        
    }
    
    private func parseUserLocation(dictionary: Dictionary<String, Any>) -> Bool {
        
        var success = false

        if let status = dictionary[k_status] as? String, status == k_ok {
            
            success = true
            
        }
        
        return success
        
    }
    
}
