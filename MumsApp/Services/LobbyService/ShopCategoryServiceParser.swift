import Foundation

struct ShopCategoryServiceParser: ServiceParser {
    
    func parseDataDictionary(tag: Int, dictionary: Dictionary<String, Any>) -> Bool {
        
        var success: Bool = false
        
        switch tag {
            
        case 0:
            
            success = self.parseData(dictionary: dictionary)

        default:
            
            return success
            
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

}
