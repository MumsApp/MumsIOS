import Foundation

struct FacebookServiceParser: ServiceParser {
    
    var userDefaults: MOUserDefaults
    
    func parseDataDictionary(type: ParserType, dictionary: Dictionary<String, Any>) -> Bool {
        
        print(dictionary)
        
        var success: Bool = false
        
        if let dict = dictionary[k_data] as? Dictionary<String, Any>,
            let token = dict[k_token] as? String,
            let refresh_token = dict[k_refresh_token] as? String,
            let id = dict[k_id] as? Int {
            
            let standard = "Bearer "
            
            self.userDefaults.setSecureString(standard + token, forKey: k_token)
            
            self.userDefaults.setSecureString(refresh_token, forKey: k_refresh_token)
            
            self.userDefaults.setInteger(id, forKey: k_id)
            
            _ = self.userDefaults.synchronize()
            
            success = true
            
        }
        
        print(success)
        
        return success
        
    }
    
}

