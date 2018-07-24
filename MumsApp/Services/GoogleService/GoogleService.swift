import Foundation
import GoogleSignIn

let GOOGLE_REGISTER_URL = BASE_PUBLIC_URL + "google/create"

let GOOGLE_LOGIN_URL = BASE_PUBLIC_URL + "google/login"

let k_id_token = "id_token"

struct GoogleService: ResourceService {
    
    let serviceName = "GoogleService"
    
    let networkService: NetworkService
    
    let serviceParser: ServiceParser
    
    let loginServiceParser: ServiceParser
    
    func register(googleProfile: GIDGoogleUser, completion: @escaping ErrorCompletion) {
        
        let bodyParameters = [k_email: googleProfile.profile.email!,
                              k_id_token: googleProfile.authentication.idToken!,
                              k_name: googleProfile.profile.givenName!,
                              k_surname: googleProfile.profile.familyName!]
        
        if let request = URLRequest.POSTRequestJSON(urlString: GOOGLE_REGISTER_URL, bodyParameters: bodyParameters) {
            
            let response = responseHandler(completion: completion)
            
            let task = JSONRequestTask(urlRequest: request, taskCompletion: response)
            
            _ = networkService.enqueueNetworkRequest(request: task)
            
        }
        
    }
    
    func login(googleProfile: GIDGoogleUser, completion: @escaping ErrorCompletion) {
        
        let bodyParameters = [k_email: googleProfile.profile.email!, k_id_token: googleProfile.authentication.idToken!]

        if let request = URLRequest.POSTRequestJSON(urlString: GOOGLE_LOGIN_URL, bodyParameters: bodyParameters) {
            
            let response = authenticationResponse(completion: completion)
            
            let task = JSONRequestTask(urlRequest: request, taskCompletion: response)
            
            _ = networkService.enqueueNetworkRequest(request: task)
            
        }
        
    }
    
    private func authenticationResponse(completion: @escaping ErrorCompletion) -> JSONResponseCompletion {
        
        let responseCompletion: JSONResponseCompletion = { (responseOptional, errorOptional) in
            
            if let error = errorOptional {
                
                let error = error.translateErrorForResponse(responseOptional: responseOptional, inDomain: self.serviceName)
                
                completion(error)
                
            } else {
                
                if let responseJSON = responseOptional as? Dictionary<String, Any> {
                    
                    let success = self.loginServiceParser.parseDataDictionary(type: .status, dictionary: responseJSON)
                    
                    if success == false {
                        
                        let userInfo = [NSLocalizedDescriptionKey: "An unknown error occured"]
                        
                        completion(NSError(domain: self.serviceName, code: 101, userInfo: userInfo))
                        
                    } else {
                        
                        completion(nil)
                        
                    }
                    
                }
                
            }
            
        }
        
        return responseCompletion
        
    }
    
}
