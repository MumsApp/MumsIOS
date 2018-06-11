import Foundation

let USER_CHILDREN_URL = BASE_URL + "user/{id}/child"
let USER_CHILDREN_DETAILS_URL = BASE_URL + "user/{id}/child/{child_id}"

let k_child_id = "child_id"

/*
 
 Child age unit
 1 - weeks
 2 - months
 3 - years
 
 Child sex
 1 - male
 2 - female
 
 */

struct ChildService: ResourceService {
    
    let serviceName = "ChildService"
    
    let networkService: NetworkService
    
    let serviceParser: ServiceParser
    
    // MARK: - GET CHILD DETAILS
    
    func getChildDetails(id: String, child_id: String, token: String, completion: @escaping JSONResponseCompletion) {
        
        let pathParameters = [k_id: id, k_child_id: child_id]
        
        let url = USER_CHILDREN_DETAILS_URL.URLReplacingPathParamaters(parameters: pathParameters)
        
        if var request = URLRequest.GETRequest(urlString: url) {
            
            request.setValue(token, forHTTPHeaderField: kAuthorization)
            
            let response = responseHandler(tag: 0, completion: completion)
            
            let task = JSONRequestTask(urlRequest: request, taskCompletion: response)
            
            _ = self.networkService.enqueueNetworkRequest(request: task)
            
        }
        
    }
    
    // MARK: - UPDATE CHILD DETAILS
    
    func updateChildDetails(id: String, child_id: Int, token: String, age: Int, ageUnit: Int, sex: Int, completion: @escaping ErrorCompletion) {
        
        let pathParameters = [k_id: id, k_child_id: String(child_id)]

        let url = USER_CHILDREN_DETAILS_URL.URLReplacingPathParamaters(parameters: pathParameters)
        
        let bodyParameters = [k_age: age, k_ageUnit: ageUnit, k_sex: sex]
        
        if var request = URLRequest.PUTRequestJSON(urlString: url, bodyParameters: bodyParameters) {
            
            request.setValue(token, forHTTPHeaderField: kAuthorization)
            
            let response = responseHandler(tag: 1, completion: completion)
            
            let task = JSONRequestTask(urlRequest: request, taskCompletion: response)
            
            _ = self.networkService.enqueueNetworkRequest(request: task)
            
        }
        
    }
    
    // MARK: - DELETE CHILD DETAILS
    
    func deleteChildDetails(id: String, child_id: Int, token: String, completion: @escaping ErrorCompletion) {
        
        let pathParameters = [k_id: id, k_child_id: String(child_id)]

        let url = USER_CHILDREN_DETAILS_URL.URLReplacingPathParamaters(parameters: pathParameters)
        
        if var request = URLRequest.DELETERequest(urlString: url) {
        
            request.setValue(token, forHTTPHeaderField: kAuthorization)
            
            let response = responseHandler(tag: 2, completion: completion)
            
            let task = JSONRequestTask(urlRequest: request, taskCompletion: response)
            
            _ = self.networkService.enqueueNetworkRequest(request: task)
            
        }
        
    }
    
    // MARK: - ADD CHILD DETAILS
    
    func addChildDetails(id: String, token: String, age: Int, ageUnit: Int, sex: Int, completion: @escaping ErrorCompletion) {
        
        let pathParameters = [k_id: id]
        
        let url = USER_CHILDREN_URL.URLReplacingPathParamaters(parameters: pathParameters)
        
        let bodyParameters = [k_age: age, k_ageUnit: ageUnit, k_sex: sex]
        
        if var request = URLRequest.POSTRequestJSON(urlString: url, bodyParameters: bodyParameters) {
            
            request.setValue(token, forHTTPHeaderField: kAuthorization)
            
            let response = responseHandler(tag: 3, completion: completion)
            
            let task = JSONRequestTask(urlRequest: request, taskCompletion: response)
            
            _ = self.networkService.enqueueNetworkRequest(request: task)
            
        }
        
    }
    
}
