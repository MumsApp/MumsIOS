import Foundation

struct ChildServiceParser: ServiceParser {
    
    func parseDataDictionary(tag: Int, dictionary: Dictionary<String, Any>) -> Bool {
        
        var success: Bool = false
        
        switch tag {
            
        case 0:
            
            
//            success = self.parseUserDetails(dictionary: dictionary)
            return success
        case 1:
            
//            success = self.parseUserName(dictionary: dictionary)
            return success
        case 2:
            
//            success = self.parseUserChildren(dictionary: dictionary)
            return success
        case 3:
            
            success = self.parseAddChild(dictionary: dictionary)

        default:
            
            return success
            
        }
        
        return success
        
    }
    
    private func parseAddChild(dictionary: Dictionary<String, Any>) -> Bool {
        
        var success = false
        
        if let status = dictionary[k_status] as? String, status == k_ok {
            
            success = true
            
        }
        
        return success
        
    }
    
}
