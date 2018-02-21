import Foundation

struct ForgotPasswordServiceParser: ServiceParser {
    
    func parseDataDictionary(tag: Int, dictionary: Dictionary<String, Any>) -> Bool {
        
        print(dictionary)
        
        var success: Bool = false
        
        if let status = dictionary[k_status] as? String, status == k_ok {
            
            success = true
            
        }
        
        return success
        
    }
    
}

