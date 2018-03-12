import Foundation

protocol ResourceService {
    
    var networkService: NetworkService { get }
    
    var serviceParser: ServiceParser { get }
    
    var serviceName: String { get }
    
}

protocol Resource {
    
    static func fromDictionary(dictionary: Dictionary<String, Any>) -> Self
    
}

/// Used to handle network request answer
extension ResourceService {
    
    /// Used to handle response and return Error completion
    func responseHandler(tag: Int = 0, completion: @escaping ErrorCompletion) -> JSONResponseCompletion {
        
        let responseCompletion: JSONResponseCompletion = { (responseOptional: Any?, errorOptional: Error?) in
            
            DispatchQueue.global(qos: .background).async {
                
                print(responseOptional as Any)
                
                var completionError: Error? = nil
                
                if let error = errorOptional {
                    
                    completionError = error.translateErrorForResponse(responseOptional: responseOptional, inDomain: self.serviceName)
                    
                } else {
                    
                    var success = false
                    
                    if responseOptional == nil {
                        
                        success = true
                        
                    } else {
                        
                        if let resposne = responseOptional as? Dictionary<String, Any> {
                            
                            success = self.serviceParser.parseDataDictionary(tag: tag, dictionary: resposne)
                            
                        }
                        
                    }
                    
                    if success == false {
                        
                        let userInfo = [NSLocalizedDescriptionKey: "An unknown error occured"]
                        
                        completionError = NSError(domain: self.serviceName, code: 101, userInfo: userInfo)
                        
                    }
                    
                }
                
                DispatchQueue.main.async {
                    
                    completion(completionError)
                    
                }
                
            }
            
        }
        
        return responseCompletion
        
    }
    
    /// Used to handle response and return JSON completion
    func responseHandler(tag: Int = 0, completion: @escaping JSONResponseCompletion) -> JSONResponseCompletion {
        
        let responseCompletion: JSONResponseCompletion = { (responseOptional: Any?, errorOptional: Error?) in
            
            DispatchQueue.global(qos: .background).async {
                
                print(responseOptional as Any)
                
                var completionError: Error? = nil
                                
                if let error = errorOptional {
                    
                    completionError = error.translateErrorForResponse(responseOptional: responseOptional, inDomain: self.serviceName)
                    
                } else {
                    
                    if responseOptional != nil {
                        
                        _ = self.serviceParser.parseDataDictionary(tag: tag, dictionary: responseOptional as! Dictionary<String, Any>)
                        
                    }
                    
                }
                
                DispatchQueue.main.async {
                    
                    completion(responseOptional, completionError)
                
                }
                
            }
            
        }
        
        return responseCompletion
        
    }
    
}

extension Error {
    
    /// Used to handle error response
    func translateErrorForResponse(responseOptional: Any?, inDomain domain: String) -> Error {
        
        let defaultUserInfo = [NSLocalizedDescriptionKey: self.localizedDescription, NSUnderlyingErrorKey: self] as [String : Any]
        
        var error: Error = NSError(domain: domain, code: self._code, userInfo: defaultUserInfo)
        
        if let dictionary = responseOptional as? [String: Any] {
            
            let message = dictionary["exceptionName"] as? String
                        
            var userInfo: [String: Any] = [:]
            
            userInfo[NSLocalizedDescriptionKey] = message == nil ? "An unknown error occured" : message!
            
            userInfo[NSUnderlyingErrorKey] = self
            
            error = NSError(domain: domain, code: self._code, userInfo: userInfo)
            
        }
        
        return error
        
    }
    
}

