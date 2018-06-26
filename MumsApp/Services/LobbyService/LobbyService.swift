import Foundation
import UIKit


let LOBBY_URL = BASE_URL + "lobby/room/page/{page}/" + PAGINATION
let LOBBY_FAVOURITE_URL = BASE_URL + "lobby/room/{id}/favourite"

let LOBBY_UPDATE_URL = BASE_URL + "lobby/room/{id}"

let k_page = "page"
let k_public = "public"

struct LobbyService: ResourceService {
    
    let serviceName = "LobbyService"
    
    let networkService: NetworkService
    
    let serviceParser: ServiceParser

    // MARK: - Get lobby rooms data with pagination
    
    func getLobbyRoomsWithPagination(token: String, page: Int, completion: @escaping JSONResponseCompletion) {
        
        let pathParameters = [k_page: String(page)]
        
        let url = LOBBY_URL.URLReplacingPathParamaters(parameters: pathParameters)
        
        if var request = URLRequest.GETRequest(urlString: url) {
            
            request.setValue(token, forHTTPHeaderField: kAuthorization)
            
            let response = responseHandler(tag: 0, completion: completion)
            
            let task = JSONRequestTask(urlRequest: request, taskCompletion: response)
            
            _ = self.networkService.enqueueNetworkRequest(request: task)
            
        }
        
    }
    
    // MARK: - Add favourite lobby room

    func addFavouriteLobbyRoom(lobbyId: String, token: String, completion: @escaping ErrorCompletion) {
        
        let pathParameters = [k_id: lobbyId]
        
        let url = LOBBY_FAVOURITE_URL.URLReplacingPathParamaters(parameters: pathParameters)
        
        if var request = URLRequest.POSTRequestData(urlString: url) {
            
            request.setValue(token, forHTTPHeaderField: kAuthorization)
            
            let response = responseHandler(tag: 1, completion: completion)
            
            let task = JSONRequestTask(urlRequest: request, taskCompletion: response)
            
            _ = self.networkService.enqueueNetworkRequest(request: task)
            
        }
        
    }
    
    // MARK: - Remove favourite lobby room

    func removeFavouriteLobbyRoom(lobbyId: String, token: String, completion: @escaping ErrorCompletion) {
        
        let pathParameters = [k_id: lobbyId]
        
        let url = LOBBY_FAVOURITE_URL.URLReplacingPathParamaters(parameters: pathParameters)
        
        if var request = URLRequest.DELETERequest(urlString: url) {
            
            request.setValue(token, forHTTPHeaderField: kAuthorization)
            
            let response = responseHandler(tag: 1, completion: completion)
            
            let task = JSONRequestTask(urlRequest: request, taskCompletion: response)
            
            _ = self.networkService.enqueueNetworkRequest(request: task)
            
        }
        
    }
    
    // MARK: - Update lobby room
    
    func deleteLobbyRoom(lobbyId: String, token: String, completion: @escaping ErrorCompletion) {
        
        let pathParameters = [k_id: lobbyId]
        
        let url = LOBBY_UPDATE_URL.URLReplacingPathParamaters(parameters: pathParameters)
        
        if var request = URLRequest.DELETERequest(urlString: url) {
            
            request.setValue(token, forHTTPHeaderField: kAuthorization)
            
            let response = responseHandler(tag: 1, completion: completion)
            
            let task = JSONRequestTask(urlRequest: request, taskCompletion: response)
            
            _ = self.networkService.enqueueNetworkRequest(request: task)
            
        }
        
    }
    
}
