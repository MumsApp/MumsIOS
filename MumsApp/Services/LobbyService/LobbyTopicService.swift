import Foundation
import UIKit

let LOBBY_TOPIC_URL = BASE_URL + "lobby/room/{roomId}/topic/page/{page}/" + PAGINATION
let LOBBY_ADD_TOPIC_URL = BASE_URL + "lobby/room/{roomId}/topic"

let k_roomId = "roomId"

struct LobbyTopicService: ResourceService {
    
    let serviceName = "LobbyService"
    
    let networkService: NetworkService
    
    let serviceParser: ServiceParser
    
    // MARK: - Get lobby rooms data with pagination
    
    func getLobbyTopicsWithPagination(roomId: String, token: String, page: Int, completion: @escaping JSONResponseCompletion) {
        
        let pathParameters = [k_roomId: roomId, k_page: String(page)]
        
        let url = LOBBY_TOPIC_URL.URLReplacingPathParamaters(parameters: pathParameters)
        
        if var request = URLRequest.GETRequest(urlString: url) {
            
            request.setValue(token, forHTTPHeaderField: kAuthorization)
            
            let response = responseHandler(type: .data, completion: completion)
            
            let task = JSONRequestTask(urlRequest: request, taskCompletion: response)
            
            _ = self.networkService.enqueueNetworkRequest(request: task)
            
        }
        
    }
    
    // MARK: - Add lobby room topic
    
    func addLobbyTopic(roomId: String, token: String, title: String, description: String, completion: @escaping JSONResponseCompletion) {
        
        let pathParameters = [k_roomId: roomId]
        
        let url = LOBBY_ADD_TOPIC_URL.URLReplacingPathParamaters(parameters: pathParameters)
        
        let bodyParameters = [k_title: title, k_description: description]
        
        if var request = URLRequest.POSTRequestJSON(urlString: url, bodyParameters: bodyParameters) {
            
            request.setValue(token, forHTTPHeaderField: kAuthorization)
            
            let response = responseHandler(type: .status, completion: completion)
            
            let task = JSONRequestTask(urlRequest: request, taskCompletion: response)
            
            _ = self.networkService.enqueueNetworkRequest(request: task)
            
        }
        
    }
}
