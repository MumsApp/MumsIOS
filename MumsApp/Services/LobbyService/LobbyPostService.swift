import Foundation
import UIKit

let LOBBY_POST_URL = BASE_URL + "lobby/room/{roomId}/topic/{topicId}/post/page/{page}/" + PAGINATION
let LOBBY_ADD_POST_URL = BASE_URL + "lobby/room/{roomId}/topic/{topicId}/post"

let k_topicId = "topicId"
let k_posts = "posts"

struct LobbyPostService: ResourceService {

    let serviceName = "LobbyPostService"
    
    let networkService: NetworkService
    
    let serviceParser: ServiceParser
    
    // MARK: - Get lobby room post data with pagination
    
    func getLobbyPostsWithPagination(roomId: String, topicId: String, token: String, page: Int, completion: @escaping JSONResponseCompletion) {
        
        let pathParameters = [k_roomId: roomId, k_topicId: topicId, k_page: String(page)]
        
        let url = LOBBY_POST_URL.URLReplacingPathParamaters(parameters: pathParameters)
        
        if var request = URLRequest.GETRequest(urlString: url) {
            
            request.setValue(token, forHTTPHeaderField: kAuthorization)
            
            let response = responseHandler(tag: 0, completion: completion)
            
            let task = JSONRequestTask(urlRequest: request, taskCompletion: response)
            
            _ = self.networkService.enqueueNetworkRequest(request: task)
            
        }
        
    }
    
    // MARK: - Add lobby room post
    
    func addLobbyPost(roomId: String, topicId: String, description: String, token: String, completion: @escaping JSONResponseCompletion) {
        
        let pathParameters = [k_roomId: roomId, k_topicId: topicId]
        
        let url = LOBBY_ADD_POST_URL.URLReplacingPathParamaters(parameters: pathParameters)
        
        let bodyParameters = [k_description: description]
        
        if var request = URLRequest.POSTRequestJSON(urlString: url, bodyParameters: bodyParameters) {
            
            request.setValue(token, forHTTPHeaderField: kAuthorization)
            
            let response = responseHandler(tag: 1, completion: completion)
            
            let task = JSONRequestTask(urlRequest: request, taskCompletion: response)
            
            _ = self.networkService.enqueueNetworkRequest(request: task)
            
        }
        
    }

}
