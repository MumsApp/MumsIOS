import Foundation

let k_data = "data"

struct UserDataServiceParser: ServiceParser {
    
    func parseDataDictionary(tag: Int, dictionary: Dictionary<String, Any>) -> Bool {
        
        print(dictionary)
        
        var success: Bool = false
        
        if let status = dictionary[k_status] as? String, status == k_ok {
            
            success = true

            if let dataDictionary = dictionary[k_data] as? Dictionary<String, Any> {
                
                let userData = UserData(dictionary: dataDictionary)
                
                print(userData)
                
            }
        
        }
        
        return success
        
    }
    
}
