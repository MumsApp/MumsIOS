import Foundation
import FBSDKCoreKit
import FBSDKLoginKit

let FACEBOOK_REGISTER_URL = BASE_PUBLIC_URL +  "facebook/create"
let FACEBOOK_LOGIN_URL = BASE_PUBLIC_URL + "facebook/login"

let k_access_token = "access_token"

struct FacebookProfile {
    
    var id: String?, email: String?, name: String?, surname: String?, imageURL: String?, token: String?
    
}

struct FacebookService: ResourceService {
    
    let serviceName = "FacebookLoginService"

    let loginManager: FBSDKLoginManager
    
    let networkService: NetworkService
    
    let serviceParser: ServiceParser

    let loginServiceParser: ServiceParser
    
    func performFacebookLogin(_ fromViewController: UIViewController, completion: @escaping (_ token: String?, _ optionalError: NSError?) -> Void) {
        
        let permissions = ["public_profile", "email"]
        
        self.loginManager.logIn(withReadPermissions: permissions, from: fromViewController, handler: { resultOptional, errorOptional in
            
            if let error = errorOptional {
                
                completion(nil, error as NSError)
                
            } else {
                
                if resultOptional?.token != nil {
                    
                    completion(resultOptional?.token.tokenString, nil)
                    
                } else {
                    
                    completion(nil, NSError(domain: "Error", code: 400, userInfo: nil))
                    
                }
                
            }
            
        })
        
    }
    
    func getUserProfile(_ token: String, completion: @escaping (_ facebookProfile: FacebookProfile, _ errorOptional: Error?) -> Void) {
        
        let graphPath = ["fields": "first_name, last_name, email, picture.width(640).height(640)"]
        
        FBSDKGraphRequest(graphPath: "me", parameters: graphPath, httpMethod: "GET").start { (connection, response, error) in
            
            let emptyProfile = FacebookProfile()

            if error == nil {

                guard let profileDictionary = response as? Dictionary<String, Any> else {

                    completion(emptyProfile, NSError(domain: "Error", code: 400, userInfo: nil))

                    return
                
                }

                guard let _ = profileDictionary["id"] as? String else {

                    completion(emptyProfile, NSError(domain: "Error", code: 400, userInfo: nil))

                    return
               
                }

                var facebookProfile = FacebookProfile()
                
                facebookProfile.email = profileDictionary["email"] as? String ?? ""
                facebookProfile.name = profileDictionary["first_name"] as? String ?? ""
                facebookProfile.surname = profileDictionary["last_name"] as? String ?? ""
                facebookProfile.id = profileDictionary["id"] as? String
                facebookProfile.token = token
                
                if let pictureDictionary = profileDictionary["picture"] as? Dictionary<String, Any> {

                    if let dataDictionary = pictureDictionary["data"] as? Dictionary<String, Any> {

                        if let profileImageURL = dataDictionary["url"] as? String {

                            facebookProfile.imageURL = profileImageURL
                    
                        }
                
                    }
                
                }

                completion(facebookProfile, nil)

            } else {

                completion(emptyProfile, error)

            }
            
        }
        
    }
    
    func logout() {
        
        self.loginManager.logOut()
        
    }
    
    func register(facebookProfile: FacebookProfile, completion: @escaping ErrorCompletion) {
        
        let bodyParameters = [k_email: facebookProfile.email!,
                              k_access_token: facebookProfile.token!,
                              k_name: facebookProfile.name!,
                              k_surname: facebookProfile.surname!]
                
        if let request = URLRequest.POSTRequestJSON(urlString: FACEBOOK_REGISTER_URL, bodyParameters: bodyParameters) {
            
            let response = responseHandler(type: .status, completion: completion)
            
            let task = JSONRequestTask(urlRequest: request, taskCompletion: response)
            
            _ = networkService.enqueueNetworkRequest(request: task)
            
        }
        
    }
    
    func login(facebookProfile: FacebookProfile, completion: @escaping ErrorCompletion) {

        let bodyParameters = [k_email: facebookProfile.email!, k_access_token: facebookProfile.token!]
        
        if let request = URLRequest.POSTRequestJSON(urlString: FACEBOOK_LOGIN_URL, bodyParameters: bodyParameters) {
            
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
