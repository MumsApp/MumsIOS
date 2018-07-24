import Foundation

enum ParserType {
    
    case data
    case status
    
}

struct Parser: ServiceParser {
    
    func parseDataDictionary(type: ParserType, dictionary: Dictionary<String, Any>) -> Bool {
        
        var success: Bool = false
        
        switch type {
            
        case .data:
            
            success = self.parseData(dictionary: dictionary)
            
        case .status:
            
            success = self.parseStatus(dictionary: dictionary)
   
        }
        
        return success
        
    }
    
    private func parseData(dictionary: Dictionary<String, Any>) -> Bool {
        
        var success = false
        
        if let status = dictionary[k_status] as? String, status == k_ok {
            
            if let _ = dictionary[k_data] as? Array<Dictionary<String, Any>> {
                
                success = true
                
            }
            
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
