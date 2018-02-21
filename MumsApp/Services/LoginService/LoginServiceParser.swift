import Foundation

let k_refresh_token = "refresh_token"

struct LoginServiceParser: ServiceParser {
    
    var userDefaults: MOUserDefaults
    
    func parseDataDictionary(tag: Int, dictionary: Dictionary<String, Any>) -> Bool {
        
        print(dictionary)
        
        var success: Bool = false
        
        if let token = dictionary[k_token] as? String,
            let refresh_token = dictionary[k_refresh_token] as? String,
            let id = dictionary[k_id] as? Int {
            
            let standard = "Bearer "
            
            self.userDefaults.setSecureString(standard + token, forKey: k_token)
            
            self.userDefaults.setSecureString(refresh_token, forKey: k_refresh_token)

            self.userDefaults.setInteger(id, forKey: k_id)
            
            _ = self.userDefaults.synchronize()
            
            success = true

        }
        
        return success
        
    }
    
}

