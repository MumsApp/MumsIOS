import Foundation
import Alamofire

fileprivate let REFRESH_SESSION_URL = BASE_URL + "/token/refresh"

/// Used as a key for refresh token
public let kRefreshTokenKey = "refreshToken"

/// Used as a key for request headers
let kAuthorization = "Authorization"

public protocol AuththenticatedNetworkServiceDelegate: class {
    
    func authenticatedNetworkServiceShouldReAuthenticate(service: AuththenticatedNetworkService) -> Bool
    
    func authenticatedNetworkServiceURLForAuthentication(service: AuththenticatedNetworkService) -> String
    
    func authenticatedNetworkService(service: AuththenticatedNetworkService, didReauthenticateWithToken: String)
    
    func authenticatedNetworkService(service: AuththenticatedNetworkService, failedToAuthenticateWithToken: String)
 
    func authenticatedNetworkServiceTimeout(service: AuththenticatedNetworkService)
    
    func authenticatedNetworkServiceConnected(service: AuththenticatedNetworkService)
    
}

public class AuththenticatedNetworkService: NetworkService {
    
    public weak var delegate: AuththenticatedNetworkServiceDelegate?
    
    let networkService: NetworkService
    
    let userDefaults: MOUserDefaults
    
    let sessionManager: SessionManager
    
    public init(networkService: NetworkService, userDefaults: MOUserDefaults) {
        
        self.networkService = networkService
        self.userDefaults = userDefaults
        
        self.sessionManager = SessionManager.default
        
    }
    
    public func enqueueNetworkRequest(request: NetworkRequest) -> MOOperation? {
        
        let taskCompletion = authenticatedCheckResponseHandler(request: request)
        
        let authenticatedCheckTask = DataRequestTask(urlRequest: request.urlRequest, taskCompletion: taskCompletion)
        
        let operation = networkService.enqueueNetworkRequest(request: authenticatedCheckTask)
        
        return operation
    
    }
    
    public func enqueueNetworkUploadRequest(request: NetworkUploadRequest, fileURL: URL) -> UploadOperation? {
        
        let taskCompletion = authenticatedCheckResponseHandler(request: request)
        
        let authenticatedCheckTask = DataUploadTask(urlRequest: request.urlRequest, name: request.name, fileName: request.fileName, mimeType: request.mimeType, taskCompletion: taskCompletion)
        
        let operation = networkService.enqueueNetworkUploadRequest(request: authenticatedCheckTask, fileURL: fileURL)
        
        return operation
        
    }
    
    public func enqueueNetworkUploadRequest(request: NetworkUploadRequest, data: Data) -> UploadOperation? {
        
        let taskCompletion = authenticatedCheckResponseHandler(request: request)
        
        let authenticatedCheckTask = DataUploadTask(urlRequest: request.urlRequest, name: request.name, fileName: request.fileName, mimeType: request.mimeType, taskCompletion: taskCompletion)
        
        let operation = networkService.enqueueNetworkUploadRequest(request: authenticatedCheckTask, data: data)
        
        return operation
        
    }
    
    public func enqueueNetworkMultipleUploadRequest(request: NetworkUploadRequest, multipleData: Array<Data>) -> UploadOperation? {
        
        let taskCompletion = authenticatedCheckResponseHandler(request: request)
        
        let authenticatedCheckTask = DataUploadTask(urlRequest: request.urlRequest, name: request.name, fileName: request.fileName, mimeType: request.mimeType, taskCompletion: taskCompletion)
        
        let operation = networkService.enqueueNetworkMultipleUploadRequest(request: authenticatedCheckTask, multipleData: multipleData)
        
        return operation
        
    }
    
    public func enqueueNetworkDownloadRequest(request: NetworkDownloadRequest) -> DownloadOperation? {
        
        return nil
        
    }
    
    //    public func enqueueNetworkDownloadRequest(request: NetworkDownloadRequest) -> DownloadOperation? {
    //
    //        let taskCompletion: ErrorCompletion = { errorOptional in
    //
    //        }
    //
    //        let downloadCompletion: DownloadCompletion = { fileLocation in
    //
    //        }
    //
    //        let progressCompletion: DownloadProgressCompletion = {_,_,_ in
    //
    //        }
    //
    //        return nil
    //
    //    }
    
    func authenticatedCheckResponseHandler(request: NetworkRequest) -> DataResponseCompletion {
        
        let taskCompletion: DataResponseCompletion = {
            
            (dataOptional: Data?, errorOptional: Error?)  in
            
            if let error = errorOptional {
           
                switch error._code {
                    
                case NSURLErrorTimedOut:
                    
                    self.delegate?.authenticatedNetworkServiceTimeout(service: self)
                    
                    request.handleResponse(dataOptional: dataOptional, errorOptional: errorOptional)
                    
                case 401:
                    
                    self.handleAuthtenticationErrorForTask(networkRequest: request)
                    
                case 403:
                    
                    self.delegate?.authenticatedNetworkService(service: self, failedToAuthenticateWithToken: "")
                    
                case 503:
                    
                    request.handleResponse(dataOptional: dataOptional, errorOptional: errorOptional)
                    
                default:
                    
                    request.handleResponse(dataOptional: dataOptional, errorOptional: errorOptional)
                    
                }
                
            } else {
                
                request.handleResponse(dataOptional: dataOptional, errorOptional: errorOptional)
                
                self.delegate?.authenticatedNetworkServiceConnected(service: self)
                
            }
        
        }
        
        return taskCompletion
    }
    
    func handleAuthtenticationErrorForTask(networkRequest: NetworkRequest) {
  
        guard let token = self.userDefaults.secureStringForKey(k_token) else {
            
            self.delegate?.authenticatedNetworkService(service: self, failedToAuthenticateWithToken: "")
            
            return
            
        }
        
        self.createSession(token: token, networkRequest: networkRequest)
        
    }
    
    func createSession(token: String, networkRequest: NetworkRequest) {
        
        let bodyParameters = [k_refresh_token: token]
        
        if let request = URLRequest.POSTRequestJSON(urlString: REFRESH_SESSION_URL, bodyParameters: bodyParameters) {
            
            let taskCompletion = self.refreshTokenResponseHandler(initialNetworkRequest: networkRequest)
            
            let task = JSONRequestTask(urlRequest: request, taskCompletion: taskCompletion)
            
            _ = self.networkService.enqueueNetworkRequest(request: task)
            
        }
        
    }
    
    func refreshTokenResponseHandler(initialNetworkRequest: NetworkRequest) -> JSONResponseCompletion {
        
        let refreshToken = userDefaults.secureStringForKey(k_token)
        
        let taskCompletion: JSONResponseCompletion = {
            
            (responseOptional: Any?, errorOptional: Error?) in
            
            if errorOptional == nil {

                if let dictionary = responseOptional as? [String: Any] {

                    if let token = dictionary[k_token] as? String,
                        let refresh_token = dictionary[k_refresh_token] as? String {
                        
                        let standard = "Bearer "
                        
                        self.userDefaults.setSecureString(standard + token, forKey: k_token)
                        
                        self.userDefaults.setSecureString(refresh_token, forKey: k_refresh_token)
                        
                        self.delegate?.authenticatedNetworkService(service: self, didReauthenticateWithToken: k_token)

                    }

                }

                var mutableRequest = initialNetworkRequest

                if let tokens = self.userDefaults.secureStringForKey(k_token) {

                    mutableRequest.urlRequest.setValue(tokens, forHTTPHeaderField: kAuthorization)

                    _ = self.networkService.enqueueNetworkRequest(request: mutableRequest)

                } else {

                    self.delegate?.authenticatedNetworkService(service: self, failedToAuthenticateWithToken: refreshToken!)

                    mutableRequest.handleResponse(dataOptional: nil, errorOptional: errorOptional)

                }

            } else {

                self.delegate?.authenticatedNetworkService(service: self, failedToAuthenticateWithToken: refreshToken!)

                initialNetworkRequest.handleResponse(dataOptional: nil, errorOptional: errorOptional)

            }
            
        }
        
        return taskCompletion
    
    }
  
}
