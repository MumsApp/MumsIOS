import Foundation
import UIKit

let LOBBY_ALL_ROOMS_URL = BASE_URL + "lobby/room"
let LOBBY_URL = BASE_URL + "lobby/room/page/{page}/" + PAGINATION
let LOBBY_FAVOURITE_URL = BASE_URL + "lobby/room/{id}/favourite"
let LOBBY_UPDATE_URL = BASE_URL + "lobby/room/{id}"
let LOBBY_SEARCH_URL = BASE_URL + "lobby/room/search/{page}/" + PAGINATION
let LOBBY_JOIN_URL = BASE_URL + "lobby/room/{id}/join"

let k_page = "page"
let k_public = "public"
let k_searchTerm = "searchTerm"

struct LobbyService: ResourceService {
    
    let serviceName = "LobbyService"
    
    let networkService: NetworkService
    
    let serviceParser: ServiceParser

    // MARK: - Get lobby rooms data
    
    func getLobbyRooms(token: String, completion: @escaping JSONResponseCompletion) {
        
        if var request = URLRequest.GETRequest(urlString: LOBBY_ALL_ROOMS_URL) {
            
            request.setValue(token, forHTTPHeaderField: kAuthorization)
            
            let response = responseHandler(type: .data, completion: completion)
            
            let task = JSONRequestTask(urlRequest: request, taskCompletion: response)
            
            _ = self.networkService.enqueueNetworkRequest(request: task)
            
        }
        
    }
    
    // MARK: - Get lobby rooms data with pagination
    
    func getLobbyRoomsWithPagination(token: String, page: Int, completion: @escaping JSONResponseCompletion) {
        
        let pathParameters = [k_page: String(page)]
        
        let url = LOBBY_URL.URLReplacingPathParamaters(parameters: pathParameters)
        
        if var request = URLRequest.GETRequest(urlString: url) {
            
            request.setValue(token, forHTTPHeaderField: kAuthorization)
            
            let response = responseHandler(type: .data, completion: completion)
            
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
            
            let response = responseHandler(type: .status, completion: completion)
            
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
            
            let response = responseHandler(type: .status, completion: completion)
            
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
            
            let response = responseHandler(type: .status, completion: completion)
            
            let task = JSONRequestTask(urlRequest: request, taskCompletion: response)
            
            _ = self.networkService.enqueueNetworkRequest(request: task)
            
        }
        
    }
    
    // MARK: - Search lobby rooms data with pagination
    
    func searchLobbyRoomsWithPagination(token: String, searchTerm: String, page: Int, completion: @escaping JSONResponseCompletion) {
        
        let pathParameters = [k_page: String(page)]
        
        let url = LOBBY_SEARCH_URL.URLReplacingPathParamaters(parameters: pathParameters)
        
        let bodyParameters = [k_searchTerm: searchTerm]
        
        if var request = URLRequest.GETRequest(urlString: url, bodyParameters: bodyParameters) {
            
            request.setValue(token, forHTTPHeaderField: kAuthorization)
            
            let response = responseHandler(type: .status, completion: completion)
            
            let task = JSONRequestTask(urlRequest: request, taskCompletion: response)
            
            _ = self.networkService.enqueueNetworkRequest(request: task)
            
        }
        
    }
    
    // MARK: - Join lobby room
    
    func joinLobbyRoom(lobbyId: String, token: String, completion: @escaping ErrorCompletion) {
        
        let pathParameters = [k_id: lobbyId]
        
        let url = LOBBY_JOIN_URL.URLReplacingPathParamaters(parameters: pathParameters)
        
        if var request = URLRequest.POSTRequestData(urlString: url) {
            
            request.setValue(token, forHTTPHeaderField: kAuthorization)
            
            let response = responseHandler(type: .status, completion: completion)
            
            let task = JSONRequestTask(urlRequest: request, taskCompletion: response)
            
            _ = self.networkService.enqueueNetworkRequest(request: task)
            
        }
        
    }
    
    // MARK: - Exit lobby room
    
    func exitLobbyRoom(lobbyId: String, token: String, completion: @escaping ErrorCompletion) {
        
        let pathParameters = [k_id: lobbyId]
        
        let url = LOBBY_JOIN_URL.URLReplacingPathParamaters(parameters: pathParameters)
        
        if var request = URLRequest.DELETERequest(urlString: url) {
            
            request.setValue(token, forHTTPHeaderField: kAuthorization)
            
            let response = responseHandler(type: .status, completion: completion)
            
            let task = JSONRequestTask(urlRequest: request, taskCompletion: response)
            
            _ = self.networkService.enqueueNetworkRequest(request: task)
            
        }
        
    }
    
}
