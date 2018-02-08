import Foundation

public func dictionaryFromJSONFile(name: String, bundle: Bundle) -> Any? {
    
    var responseData: Any?
    
    let path = bundle.url(forResource: name, withExtension: nil)
    
    if let path = path {
        
        do {
            
            let data = try Data(contentsOf: path)
            
            do {
                
                responseData = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                
            } catch {}
            
        } catch {}
        
    }
    
    return  responseData
    
}
