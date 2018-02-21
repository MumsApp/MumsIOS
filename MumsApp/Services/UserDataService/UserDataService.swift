import Foundation

let USER_DATA_URL = BASE_URL + "user/{id}/{level}"

let k_level = "level"

struct UserDataService: ResourceService {
    
    let serviceName = "UserDataService"
    
    let networkService: NetworkService
    
    let serviceParser: ServiceParser
    
    func getUserData(id: String, token: String, completion: @escaping ErrorCompletion) {
        
        let pathParameters = [k_id: id, k_level: "7"]
        
        let url = USER_DATA_URL.URLReplacingPathParamaters(parameters: pathParameters)
        
        if var request = URLRequest.GETRequest(urlString: url) {
            
            request.setValue(token, forHTTPHeaderField: kAuthorization)

            let response = responseHandler(completion: completion)

            let task = JSONRequestTask(urlRequest: request, taskCompletion: response)
            
            _ = self.networkService.enqueueNetworkRequest(request: task)
            
        }
        
    }
    
}

