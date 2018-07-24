import Foundation

let REGISTER_URL = BASE_PUBLIC_URL + "user/create"

let k_email = "email"
let k_password = "password"
let k_name = "name"
let k_surname = "surname"
let k_ok = "ok"
let k_status = "status"

struct RegisterService: ResourceService {
    
    let serviceName = "RegisterService"
    
    let networkService: NetworkService
    
    let serviceParser: ServiceParser
    
    func register(email: String, password: String, name: String, surname: String, completion: @escaping ErrorCompletion) {
        
        let bodyParams = [k_email: email, k_password: password, k_name: name, k_surname: surname]
        
        if let request = URLRequest.POSTRequestJSON(urlString: REGISTER_URL, bodyParameters: bodyParams) {
            
            let response = responseHandler(type: .status, completion: completion)
            
            let task = JSONRequestTask(urlRequest: request, taskCompletion: response)
            
            _ = self.networkService.enqueueNetworkRequest(request: task)
            
        }
        
    }
    
}


