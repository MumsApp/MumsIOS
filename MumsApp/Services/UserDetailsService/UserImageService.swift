import Foundation
import UIKit

let USER_PHOTO_URL = BASE_URL + "user/{id}/photo"

let kImageServiceErrorCode = 501

class UserImageService {
    
    let networkService: NetworkService
    
    let dataStore: DataStore
    
    var imageUploadOperation: UploadOperation!
    
    init(networkService: NetworkService, dataStore: DataStore) {
        
        self.networkService = networkService
        self.dataStore = dataStore
    
    }
    
    func updateUserImage(imageURL: String, token: String, image: UIImage, completion: @escaping ErrorCompletion) {
        
        if var request = URLRequest.PUTRequestData(urlString: imageURL, bodyData: nil) {
        
            request.setValue(token, forHTTPHeaderField: kAuthorization)

            self.performUserImageUploadWithRequest(request, image: image, completion: completion)

        }
    
    }
    
    func postNewUserImage(id: String, token: String, image: UIImage, completion: @escaping ErrorCompletion) {
        
        let pathParameters = [k_id: id]
        
        let imageLink = USER_PHOTO_URL.URLReplacingPathParamaters(parameters: pathParameters)
        
        if var request = URLRequest.POSTRequestData(urlString: imageLink) {
            
            request.setValue(token, forHTTPHeaderField: kAuthorization)
            
            self.performUserImageUploadWithRequest(request, image: image, completion: completion)
            
        }
        
    }
    
    func performUserImageUploadWithRequest(_ requestOptional: URLRequest?, image: UIImage, completion: @escaping ErrorCompletion) {
        
        let imageDataOptional = UIImageJPEGRepresentation(image, 0.7)
        
        if let request = requestOptional, let imageData = imageDataOptional {
            
            let networkRequest = DataUploadJsonResponseTask(urlRequest: request, name: "file", fileName: "iosFile.jpg", mimeType: "image/jpg") {
                
                (responseOptional, errorOptional) in
                
                self.handleImageResponse(responseOptional: responseOptional, errorOptional: errorOptional, errorCompletion: completion)
                
            }
            
            self.imageUploadOperation = self.networkService.enqueueNetworkUploadRequest(request: networkRequest, data: imageData)
            
        }
        
    }
    
    func handleImageResponse(responseOptional: Any?, errorOptional: Error?, errorCompletion: ErrorCompletion) {
        
        let userInfo = [NSLocalizedDescriptionKey: NSLocalizedString("There was an error uploading the image", comment: "")]
        
        var error: NSError? = NSError(domain: "UserImageService", code: kImageServiceErrorCode, userInfo: userInfo)
        
        if let dictionary = responseOptional as? [String: AnyObject] {
            
            if let status = dictionary[k_status] as? String, status == k_ok {
                
                errorCompletion(nil)

            } else {
                
                errorCompletion(error)

            }
            
        }
        
    }
    
}
