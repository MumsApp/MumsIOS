import Foundation

let USER_DETAILS_URL = BASE_URL + "user/{id}/{level}"
let USER_NAME_URL = BASE_URL + "user/{id}"
let USER_CHILDREN_URL = BASE_URL + "user/{id}/children"
let USER_LOCATION_URL = BASE_URL + "user/{id}/location"
let USER_PHOTO_URL = BASE_URL + "user/{id}/photo"

let k_level = "level"

struct UserDetailsService: ResourceService {
    
    let serviceName = "UserDetailsService"
    
    let networkService: NetworkService
    
    let serviceParser: ServiceParser
    
    // MARK: - GET USER DETAILS

    func getUserDetails(id: String, token: String, completion: @escaping JSONResponseCompletion) {
        
        let pathParameters = [k_id: id, k_level: "7"]
        
        let url = USER_DETAILS_URL.URLReplacingPathParamaters(parameters: pathParameters)
        
        if var request = URLRequest.GETRequest(urlString: url) {
            
            request.setValue(token, forHTTPHeaderField: kAuthorization)
            
            let response = responseHandler(tag: 0, completion: completion)

            let task = JSONRequestTask(urlRequest: request, taskCompletion: response)
            
            _ = self.networkService.enqueueNetworkRequest(request: task)
            
        }
        
    }
    
    // MARK: - UPDATE NAME

    func updateUserName(id: String, token: String, name: String, surname: String, description: String, completion: @escaping ErrorCompletion) {
        
        let pathParameters = [k_id: id]
        
        let url = USER_NAME_URL.URLReplacingPathParamaters(parameters: pathParameters)
        
        let bodyParameters = [k_name: name, k_surname: surname, k_description: description]
        
        if var request = URLRequest.PUTRequestJSON(urlString: url, bodyParameters: bodyParameters) {
            
            request.setValue(token, forHTTPHeaderField: kAuthorization)
            
            let response = responseHandler(tag: 1, completion: completion)
            
            let task = JSONRequestTask(urlRequest: request, taskCompletion: response)
            
            _ = self.networkService.enqueueNetworkRequest(request: task)
            
        }
        
    }
  
    // MARK: - UPDATE CHILDREN

    func updateUserChildren(id: String, token: String, number: Int, ageRangeFrom: Int, ageRangeTo: Int, completion: @escaping ErrorCompletion) {
        
        let pathParameters = [k_id: id]
        
        let url = USER_CHILDREN_URL.URLReplacingPathParamaters(parameters: pathParameters)
        
        let bodyParameters = [k_number: number, k_ageRangeFrom: ageRangeFrom, k_ageRangeTo: ageRangeTo]
        
        if var request = URLRequest.PUTRequestJSON(urlString: url, bodyParameters: bodyParameters) {
            
            request.setValue(token, forHTTPHeaderField: kAuthorization)
            
            let response = responseHandler(tag: 2, completion: completion)
            
            let task = JSONRequestTask(urlRequest: request, taskCompletion: response)
            
            _ = self.networkService.enqueueNetworkRequest(request: task)
            
        }
        
    }

    // MARK: - UPDATE LOCATION

    func updateUserLocation(id: String, token: String, name: String, placeID: Int, lat: Double, lon: Double, formattedAddress: String, completion: @escaping ErrorCompletion) {
        
        let pathParameters = [k_id: id]
        
        let url = USER_LOCATION_URL.URLReplacingPathParamaters(parameters: pathParameters)
        
        let bodyParameters = [k_name: name, k_placeID: placeID, k_lat: lat, k_lon: lon, k_formattedAddress: formattedAddress] as [String : Any]
        
        if var request = URLRequest.PUTRequestJSON(urlString: url, bodyParameters: bodyParameters) {
            
            request.setValue(token, forHTTPHeaderField: kAuthorization)
            
            let response = responseHandler(tag: 3, completion: completion)
            
            let task = JSONRequestTask(urlRequest: request, taskCompletion: response)
            
            _ = self.networkService.enqueueNetworkRequest(request: task)
            
        }
        
    }
  
    // MARK: - UPDATE PHOTO
    
    func updateUserPhoto(id: String, token: String, photo: Data, completion: @escaping ErrorCompletion) {
        
        let pathParameters = [k_id: id]
        
        let url = USER_PHOTO_URL.URLReplacingPathParamaters(parameters: pathParameters)
        
        if var request = URLRequest.POSTRequestData(urlString: url, bodyData: photo) {
            
            request.setValue(token, forHTTPHeaderField: kAuthorization)
            
            let response = responseHandler(completion: completion)
            
            let task = JSONRequestTask(urlRequest: request, taskCompletion: response)
            
            _ = self.networkService.enqueueNetworkRequest(request: task)
            
        }
        
    }
    
}

