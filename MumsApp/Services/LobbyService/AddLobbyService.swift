import Foundation
import UIKit
import Alamofire

let LOBBY_ADD_URL = BASE_URL + "lobby/room?title={title}&description={description}&public={public}"

struct AddLobbyService: ResourceService {
    
    let serviceName = "AddLobbyService"
    
    let serviceParser: ServiceParser
    
    let networkService: NetworkService

    // MARK: - Add lobby room
    
    func addLobbyRoom(token: String, title: String, description: String, isPublic: Bool, image: UIImage, completion: @escaping ErrorCompletion) {
        
        let isPublic = isPublic == true ? "1" : "0"
        
        let pathParameters = [k_title: title, k_description: description, k_public: isPublic]

        let url = LOBBY_ADD_URL.URLReplacingPathParamaters(parameters: pathParameters)
        
        if var request = URLRequest.POSTRequestData(urlString: url) {
            
            request.setValue(token, forHTTPHeaderField: kAuthorization)
            
            let response = responseHandler(type: .status, completion: completion)
            
            let task = DataUploadJsonResponseTask(urlRequest: request, name: "file", fileName: "file.jpg", mimeType: "image/jpg", taskCompletion: response)
            
            let imageDataOptional = UIImageJPEGRepresentation(image, 0.1)
            
            _ = self.networkService.enqueueNetworkUploadRequest(request: task, data: imageDataOptional!)
            
        }
    
    }

}
