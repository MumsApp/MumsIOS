import Foundation

let LOGIN_URL = BASE_URL + "login_check"

let k_username = "username"

struct LoginService: ResourceService {
    
    let serviceName = "LoginService"
    
    let networkService: NetworkService
    
    let serviceParser: ServiceParser
    
    func login(email: String, password: String, completion: @escaping ErrorCompletion) {
        
        let bodyParams = [k_username: email, k_password: password]
        
        if let request = URLRequest.POSTRequestJSON(urlString: LOGIN_URL, bodyParameters: bodyParams) {
            
            let response = responseHandler(completion: completion)
            
            let task = JSONRequestTask(urlRequest: request, taskCompletion: response)
            
            _ = self.networkService.enqueueNetworkRequest(request: task)
            
        }
        
    }
    
}



