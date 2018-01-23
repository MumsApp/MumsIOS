import Foundation

let REGISTER_URL = BASE_PUBLIC_URL + "user/create"

let k_email = "email"
let k_password = "password"

struct RegisterService: ResourceService {
    
    let serviceName = "RegisterService"
    
    let networkService: NetworkService
    
    let serviceParser: ServiceParser
    
    func register(email: String, password: String, completion: @escaping ErrorCompletion) {
        
        let bodyParams = [k_email: email, k_password: password]
        
        if let request = URLRequest.POSTRequestJSON(urlString: REGISTER_URL, bodyParameters: bodyParams) {
            
            let response = responseHandler(completion: completion)
            
            let task = JSONRequestTask(urlRequest: request, taskCompletion: response)
            
            _ = self.networkService.enqueueNetworkRequest(request: task)
            
        }
        
    }
    
}


