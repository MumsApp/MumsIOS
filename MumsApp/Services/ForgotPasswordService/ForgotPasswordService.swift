import Foundation

let RESET_PASSWORD_URL = BASE_PUBLIC_URL + "user/password"

struct ForgotPasswordService: ResourceService {
    
    let serviceName = "ForgotPasswordService"
    
    let networkService: NetworkService
    
    let serviceParser: ServiceParser
    
    func reset(email: String, completion: @escaping ErrorCompletion) {
        
        let bodyParams = [k_email: email]
        
        if let request = URLRequest.POSTRequestJSON(urlString: RESET_PASSWORD_URL, bodyParameters: bodyParams) {
            
            let response = responseHandler(completion: completion)
            
            let task = JSONRequestTask(urlRequest: request, taskCompletion: response)
            
            _ = self.networkService.enqueueNetworkRequest(request: task)
            
        }
        
    }
    
}

