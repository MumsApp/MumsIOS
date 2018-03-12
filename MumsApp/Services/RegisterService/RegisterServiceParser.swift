import Foundation

let k_ok = "ok"
let k_status = "status"

struct RegisterServiceParser: ServiceParser {
      
    func parseDataDictionary(tag: Int, dictionary: Dictionary<String, Any>) -> Bool {
        
        print(dictionary)
        
        var success: Bool = false
        
        if let status = dictionary[k_status] as? String, status == k_ok {

            success = true
            
        }
        
        return success
        
    }
    
}
