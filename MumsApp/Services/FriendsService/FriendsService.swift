import Foundation

let ADD_FRIENDS_URL = BASE_URL + "user/friend/{friendId}"
let GET_FRIENDS_URL = BASE_URL + "user/friends/{page}/" + PAGINATION

let k_friendId = "friendId"

struct FriendsService: ResourceService {
    
    let serviceName = "FriendsService"
    
    let networkService: NetworkService
    
    let serviceParser: ServiceParser
    
    // MARK: - Get user friends
    
    func getFriends(page: Int, token: String, completion: @escaping JSONResponseCompletion) {
        
        let parameters = [k_page: String(page)]
        
        let url = GET_FRIENDS_URL.URLReplacingPathParamaters(parameters: parameters)
        
        if var request = URLRequest.GETRequest(urlString: url) {
            
            request.setValue(token, forHTTPHeaderField: kAuthorization)
            
            let response = responseHandler(type: .data, completion: completion)
            
            let task = JSONRequestTask(urlRequest: request, taskCompletion: response)
            
            _ = self.networkService.enqueueNetworkRequest(request: task)
            
        }
        
    }
   
    // MARK: - Add user friend
    
    func addFriend(friendId: String, token: String, completion: @escaping ErrorCompletion) {
        
        let pathParameters = [k_friendId: friendId]
        
        let url = ADD_FRIENDS_URL.URLReplacingPathParamaters(parameters: pathParameters)
        
        if var request = URLRequest.POSTRequestData(urlString: url) {
            
            request.setValue(token, forHTTPHeaderField: kAuthorization)
            
            let response = responseHandler(type: .status, completion: completion)
            
            let task = JSONRequestTask(urlRequest: request, taskCompletion: response)
            
            _ = self.networkService.enqueueNetworkRequest(request: task)
            
        }
        
    }
    
    // MARK: - Remove user friend
    
    func removeFriend(friendId: String, token: String, completion: @escaping ErrorCompletion) {
        
        let pathParameters = [k_friendId: friendId]
        
        let url = ADD_FRIENDS_URL.URLReplacingPathParamaters(parameters: pathParameters)
        
        if var request = URLRequest.DELETERequest(urlString: url) {
            
            request.setValue(token, forHTTPHeaderField: kAuthorization)
            
            let response = responseHandler(type: .status, completion: completion)
            
            let task = JSONRequestTask(urlRequest: request, taskCompletion: response)
            
            _ = self.networkService.enqueueNetworkRequest(request: task)
            
        }
        
    }
    
}
