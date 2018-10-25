import Foundation

let STATUSES_URL = BASE_URL + "socket/user/statuses?users={id}"
let LAST_MESSAGES_URL = BASE_URL + "socket/lastmessages"

let k_users = "users"

struct ChatService: ResourceService {
    
    let serviceName = "ChatService"
    
    let networkService: NetworkService
    
    let serviceParser: ServiceParser
    
    // MARK: - Check socket statueses of provided users
    
    func getChildDetails(usersIds: Array<String>, token: String, completion: @escaping JSONResponseCompletion) {
        
        let pathParameters = [k_id: usersIds.joined(separator: ",")]
        
        let url = STATUSES_URL.URLReplacingPathParamaters(parameters: pathParameters)
        
        if var request = URLRequest.GETRequest(urlString: url) {
            
            request.setValue(token, forHTTPHeaderField: kAuthorization)
            
            let response = responseHandler(type: .status, completion: completion)
            
            let task = JSONRequestTask(urlRequest: request, taskCompletion: response)
            
            _ = self.networkService.enqueueNetworkRequest(request: task)
            
        }
        
    }
    
    // MARK: - Check last messages

    func getLastMessages(token: String, completion: @escaping JSONResponseCompletion) {
        
        if var request = URLRequest.GETRequest(urlString: LAST_MESSAGES_URL) {
            
            request.setValue(token, forHTTPHeaderField: kAuthorization)
            
            let response = responseHandler(type: .status, completion: completion)
            
            let task = JSONRequestTask(urlRequest: request, taskCompletion: response)
            
            _ = self.networkService.enqueueNetworkRequest(request: task)
            
        }
        
    }
    
}
