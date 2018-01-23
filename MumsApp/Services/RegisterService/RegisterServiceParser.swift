import Foundation

let k_message = "message"

struct RegisterServiceParser: ServiceParser {
    
    func parseDataDictionary(tag: Int, dictionary: Dictionary<String, Any>) -> Bool {
        
        print(dictionary)
        
        var success: Bool = false
        
        if let message = dictionary[k_message] as? String {

            success = true
            
        }
        
        return success
        
    }
    
}
